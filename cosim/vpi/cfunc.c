#line 1 "./cfunc.mod"
#include "ngspice/cm.h"
extern void cm_d_hdl(Mif_Private_t *);
#line 1 "./digital/d_hdl/cfunc.mod"
/*******************************************************************************
**        MOD FILE (c) 2015, SiliconReef
********************************************************************************
**
**        ID:      $Id: cfunc.mod,v 1.9 2016/01/08 20:00:04 gsr Exp gsr $
**        File:    d_hdl/cfunc.mod
**        Author:  Glenn Ramalho
**        Project: ADMS
**
********************************************************************************
**
**        Description: Functional C model for the D_HDL block
**
*******************************************************************************/

#include <stdio.h>
#include <ctype.h>
#include <stdlib.h>
#include <string.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <sys/un.h>
#include <errno.h>
#include <unistd.h>
#include <math.h>

#define MAX_STRING_SIZE 200

#if defined(__MINGW32__) || defined(_MSC_VER)
#define DIR_PATHSEP    "\\"
#else
#define DIR_PATHSEP    "/"
#endif

#ifdef _MSC_VER
#define snprintf _snprintf
#endif

struct commchannel_t {
   int pipe_fd;
   int timeunit;
   double timefactor;
   int alive;
};

/*=== FUNCTION PROTOTYPE DEFINITIONS ===*/

void cm_d_fail(char *type, char *filearg, int errval);

/*==============================================================================

FUNCTION cm_d_fail()

AUTHORS

    15 May 2015     Glenn Ramalho

MODIFICATIONS

SUMMARY

    Implements a basic error reporting function.

INTERFACES

    FILE                 ROUTINE CALLED



RETURNED VALUE

    NONE

GLOBAL VARIABLES

    NONE

NON-STANDARD FEATURES

    NONE

==============================================================================*/

/* Error Handling Function */
void cm_d_fail(char *type, char *filearg, int errval) {
   char errmsg[512];
   snprintf(errmsg, 512, "cm_d_hdl: %s error: %s: %s\n", type, filearg,
	 (errval == 0)?"UNK":strerror(errval));
   cm_message_send(errmsg);
}

/*==============================================================================

FUNCTION cm_d_hdl()

AUTHORS

    15 May 2015     Glenn Ramalho

MODIFICATIONS

SUMMARY

    This function implements the d_hdl code model.

INTERFACES

    FILE                 ROUTINE CALLED

    CMmacros.h           cm_message_send();

    CMevt.c              void *cm_event_alloc()
                         void *cm_event_get_ptr()
                         int  cm_event_queue()


RETURNED VALUE

    Returns inputs and outputs via ARGS structure.

GLOBAL VARIABLES

    NONE

NON-STANDARD FEATURES

    NONE

==============================================================================*/

/*=== CM_D_SOURCE ROUTINE ==============*/
/* Main funcion */
void cm_d_hdl(Mif_Private_t *mif_private) {
   struct commchannel_t *commchannel;
   int tohdl_size, tongspice_size;
   char buffer[256];
   Digital_State_t *tongspice, *tongspice_old;
   Digital_State_t *tohdl, *tohdl_old;
   Digital_State_t *sampclk, *sampclk_old;
   int bitcnt;
   int sendok;
   int buffer_width;

   /* If we are initializing the block, then we then need to open the link
    * to the other simulator.
    */
   if (mif_private->circuit.init) {
      char *pipename;
      struct sockaddr_un pipeaddr;
      int socket_fd;
      int timeunit;
      long int readresp;

      /* ============== We setup the channel ==================== */
      /* The pipe should be present, all we need to do is open it.
       * We build the pipeaddr structure and put a ending \0 just in
       * case there is something odd with the parameter.
       */
      pipename = mif_private->param[0]->element[0].svalue;
      strncpy(pipeaddr.sun_path, mif_private->param[0]->element[0].svalue, sizeof(pipeaddr.sun_path));
      pipeaddr.sun_path[sizeof(pipeaddr.sun_path)-1] = '\0';
      pipeaddr.sun_family = AF_UNIX;
      if (0 > (socket_fd = socket(AF_UNIX, SOCK_STREAM, 0))) {
         cm_d_fail("socket", pipeaddr.sun_path, errno);
	 return;
      }
      if (0 > connect(socket_fd, (struct sockaddr *)&pipeaddr,
	       sizeof(pipeaddr))) {
	 cm_d_fail("connect", pipeaddr.sun_path, errno);
	 return;
      }

      /* We need to get the timeunit from the HDL. */
      memset(buffer, ' ', 256);
      readresp = read(socket_fd, buffer, 256);
      buffer[255] = '\0';
      if (mif_private->param[5]->element[0].bvalue) printf("NGSPICE Received Header: %s\n", buffer);
      if (readresp == 0) {
	 cm_d_fail("read", "timeunit", 0); /* Failure */
	 return;
      }
      else if (readresp < 0) {
	 cm_d_fail("read", pipeaddr.sun_path, errno); /* Failure */
	 return;
      }
      readresp = sscanf(buffer, "TU=%d", &timeunit);
      if (readresp <= 0 || timeunit > 0 || timeunit < -15) {
	 cm_d_fail("bad timeunit", "timeunit", 0); /* Failure */
	 return;
      }

      /* Now we should be ready to communicate, so we can setup the pins. */

      tohdl_size = mif_private->conn[0]->size;
      tongspice_size = mif_private->conn[1]->size;

      /* We allocate space for the output bus and connect it to the
       * tongspice and tongspice_old pointers.
       */
      cm_event_alloc(0, (int)sizeof(Digital_State_t) * tongspice_size);
      tongspice = tongspice_old = (Digital_State_t *) cm_event_get_ptr(0,0);
      /* And we set the input loads. */
      for(bitcnt = 0; bitcnt < tohdl_size; bitcnt = bitcnt + 1) {
	 mif_private->conn[0]->port[bitcnt]->load = mif_private->param[1]->element[0].rvalue;
      }

      /* We need to find out if there was a trigger. It can be either
       * on the clock or on the input bus. That depends what mode this
       * is.
       */
      if (mif_private->conn[2]->is_null) {
	 /* ToHDL Bus is the trigger */
	 sampclk = sampclk_old = NULL;
	 cm_event_alloc(1, (int)sizeof(Digital_State_t) * tohdl_size);
	 tohdl = tohdl_old = (Digital_State_t *) cm_event_get_ptr(1,0);
      }
      else {
	 /* sampclk is the trigger */
	 tohdl = tohdl_old = NULL;
	 cm_event_alloc(1, sizeof(Digital_State_t));
	 sampclk = sampclk_old = (Digital_State_t *) cm_event_get_ptr(1,0);
	 mif_private->conn[2]->port[0]->load = mif_private->param[2]->element[0].rvalue;
      }

      /* We also need to store the information on the HDL simulator in
       * a place where it can be reinvoked from one call to this function
       * to another.
       */
      mif_private->inst_var[0]->element[0].pvalue = malloc(sizeof(struct commchannel_t));
      commchannel = mif_private->inst_var[0]->element[0].pvalue;
      if (NULL == commchannel) {
	 cm_d_fail("malloc", "could not allocate space", 0);
	 return;
      }
      /* We store the timeunit and also an exponent that we can attach to
       * the TIME parameter to convert it to what the HDL wants to see.
       */
      commchannel->timeunit = timeunit;
      commchannel->timefactor = pow(10.0, timeunit);
      commchannel->pipe_fd = socket_fd;
      sprintf(buffer, "cm_d_hdl: NOTE: setting channel timeunit to %e\n",
	    commchannel->timefactor);
      cm_message_send(buffer);

      /* We mark the communication channel as alive. If we fail to talk to
       * the other simulator, then we mark it as bad so we do not produce some
       * overwhealming list of errors/warnings.
       */
      commchannel->alive = 1;

   }
   else {
      /* ========= We are returning to the function ============= */
      /* We need to restore the pin setup. */
      tohdl_size = mif_private->conn[0]->size;
      tongspice_size = mif_private->conn[1]->size;
      tongspice = (Digital_State_t *) cm_event_get_ptr(0,0);     /* Current */
      tongspice_old = (Digital_State_t *) cm_event_get_ptr(0,1); /* Previous */
      commchannel = mif_private->inst_var[0]->element[0].pvalue;
      if (mif_private->conn[2]->is_null) {
	 sampclk = sampclk_old = NULL;
	 tohdl = (Digital_State_t *) cm_event_get_ptr(1,0);
	 tohdl_old = (Digital_State_t *) cm_event_get_ptr(1,1);
      }
      else {
	 tohdl = tohdl_old = NULL;
	 sampclk = (Digital_State_t *) cm_event_get_ptr(1,0);
	 sampclk_old = (Digital_State_t *) cm_event_get_ptr(1,1);
      }
   }

   /* We grab the trigger */
   if (sampclk != NULL) *sampclk = ((Digital_t*)(mif_private->conn[2]->port[0]->input.pvalue))->state;
   else for(bitcnt = 0; bitcnt < tohdl_size; bitcnt = bitcnt + 1) {
      tohdl[bitcnt] = ((Digital_t*)(mif_private->conn[0]->port[bitcnt]->input.pvalue))->state;
   }

   /* Now we need to decide if we will be sending something to the HDL or
    * not. That depends on the triggers. At INIT we send it to get the
    * initial conditions settled. Then we do it only if there were changes.
    */
   if (mif_private->circuit.init) {
      sendok = 1;
      mif_private->inst_var[1]->element[0].ivalue = UNKNOWN;
   }
   else if (mif_private->circuit.anal_type != DC) {
      if (sampclk == NULL) {
	 sendok = 0;
	 for(bitcnt = 0; bitcnt < tohdl_size; bitcnt = bitcnt + 1) {
	    if (tohdl[bitcnt] != tohdl_old[bitcnt]) {
	       sendok = 1;
	       break;
	    }
	 }
      }
      else if (*sampclk == ZERO && *sampclk_old != ZERO
            && mif_private->inst_var[1]->element[0].ivalue != ONE) {
	 sendok = 1;
	 mif_private->inst_var[1]->element[0].ivalue = ONE;
      }
      else if (*sampclk == ONE && *sampclk_old != ONE
            && mif_private->inst_var[1]->element[0].ivalue != ZERO) {
         sendok = 1;
	 mif_private->inst_var[1]->element[0].ivalue = ZERO;
      }
      /* We ignore transitions to Unknwon. */
      else sendok = 0;

      if (mif_private->param[5]->element[0].bvalue && sendok == 1) {
	 printf("%ld -- CLK: %0d->%0d (DIR=%0d)\n",
	    (long int)round(mif_private->circuit.time/commchannel->timefactor),
	    *sampclk_old, *sampclk, mif_private->inst_var[1]->element[0].ivalue);
      }
   }

   /* For DC analysis and Transient at time 0.0 we need to pass the initial
    * conditions if any are defined.
    */
   if (sendok && mif_private->circuit.anal_type == DC) {
      int pos;

      /* We start by sending filling the buffer with any initial conditions. */
      strcpy(buffer, "#0 ");
      pos = 3;

      /* And we set every bit in the bus. If there is a clock, we set it as
       * well.
       */
      if (sampclk == NULL) buffer_width = tohdl_size + pos;
      else buffer_width = tohdl_size + pos + 1;
      if (buffer_width > 255) buffer_width = 255;

      /* And we set each bit. Note that if the ToHDL bus is floating, we set
       * it to High-Z.
       */
      for(bitcnt = pos; bitcnt < buffer_width; bitcnt = bitcnt + 1) {
	 if (mif_private->conn[0]->is_null) buffer[bitcnt] = 'z';
	 else if (mif_private->param[6]->element[0].ivalue == 0) buffer[bitcnt] = '0';
	 else if (mif_private->param[6]->element[0].ivalue == 1) buffer[bitcnt] = '1';
	 else buffer[bitcnt] = 'x';
      }

      /* And we nullterminate the string. */
      buffer[buffer_width] = '\0';
      buffer_width = buffer_width + 1;

      /* And we set the outputs to the default values, either UNKNOWN or
       * to the .ic if used. Note that the HDL might override these.
       */
      for(bitcnt = 0; bitcnt < tongspice_size; bitcnt = bitcnt + 1) {
	 if (mif_private->param[6]->element[0].ivalue == 0) tongspice[bitcnt] = tongspice_old[bitcnt] = ZERO;
	 else if (mif_private->param[6]->element[0].ivalue == 1) tongspice[bitcnt] = tongspice_old[bitcnt] = ONE;
	 else tongspice[bitcnt] = tongspice_old[bitcnt] = UNKNOWN;
      }
   }

   /* For Transient Analysis after the initial time we need to read the current
    * data on the tohdl pins into the buffer.
    */
   else if (sendok) {
      int bus_width;
      int pos;
      int bit;

      /* We start by putting the current absolute time into the buffer.
       * Again, the time is kept in absolute time to keep the simulators
       * from slipping apart due to number rounding.
       */
      pos = sprintf(buffer, "#%ld ",
	    (long int)round(mif_private->circuit.time / commchannel->timefactor));

      /* If this is a synchronous interface we put the clock first. */
      if (sampclk != NULL) {
	 if (*sampclk == ZERO) buffer[pos] = '0';
	 else if (*sampclk == ONE) buffer[pos] = '1';
	 else buffer[pos] = 'x'; /* This line should not happen. */

	 /* And we add one bit to the output. */
	 pos = pos + 1;
      }

      /* And we convert each bit in ToHDL pins to an ASCII notation.
       * In XSpice the entire bus can go Z but not individual bits. So
       * if it is all floating we give it a Z. If not we simply look at
       * the bit to tell if it should be 0 or 1. Anything else, should
       * only be undefined, we set it to X.
       */
      bus_width = tohdl_size;
      if (bus_width + pos > 255) bus_width = 255 - pos;
      for(bitcnt = 0; bitcnt < bus_width; bitcnt = bitcnt + 1) {
	 bit = bus_width - 1 - bitcnt + pos;
	 if (mif_private->conn[0]->is_null) buffer[bit] = 'z';
	 else if (((Digital_t*)(mif_private->conn[0]->port[bitcnt]->input.pvalue))->state==ZERO) buffer[bit] = '0';
	 else if (((Digital_t*)(mif_private->conn[0]->port[bitcnt]->input.pvalue))->state==ONE) buffer[bit] = '1';
	 else buffer[bit] = 'x';
      }
      /* And we null terminate the string. */
      buffer[bus_width + pos] = '\0';
      buffer_width = bus_width + pos + 1;
   }

   /* Now, if the timeslice is marked to send data, we send it. We also
    * block until we get the response. Perhaps there is a better way to
    * do that, taking advantage of some parallel processing, but that
    * can be done in the future.
    * The channel has to be alive, what means no strange errors have
    * popped up that killed the other simulator or the channel.
    */
   if (sendok && commchannel->alive) {
      /* The data should be in the buffer. So we simply write it to the
       * channel. 
       */
      if (mif_private->param[5]->element[0].bvalue) printf("Writing [%e] %s\n", mif_private->circuit.time, buffer);
      if (-1 == write(commchannel->pipe_fd, buffer, (size_t)buffer_width)) {
	 /* If writing fails, it probably means the digital simulator
	  * has stopped working. We then set the outputs to unknown label
	  * the chanel as dead, but we keep simulating.
	  */
	 cm_d_fail("write", "failed to talk message to simulator", errno);
	 for(bitcnt = 0; bitcnt < tongspice_size; bitcnt = bitcnt + 1)
	    tongspice[bitcnt] = UNKNOWN;
	 commchannel->alive = 0;
      }
      else {
	 /* The writing worked, so we now block waiting for an answer from
	  * the HDL side.
	  */
	 ssize_t readresp;

	 /* Now we try to get the answer back and store it. */
	 readresp = read(commchannel->pipe_fd, buffer, 256);
	 if (readresp <= 0) {
	    /* If we get no answer, it probably means the other simulator
	     * quit or died. Either way we need to do something. We then
	     * set the wires to unknowns, mark the channel as dead and keep
	     * going.
	     */
	    cm_d_fail("read", "could not get data from simulator", errno);
	    for(bitcnt = 0; bitcnt < tongspice_size; bitcnt = bitcnt + 1)
	       tongspice[bitcnt] = UNKNOWN;
	    commchannel->alive = 0;
	 }
	 else {
	    /* We should have the data from the HDL, so we null terminate the
	     * string as read() does not do it. We then bring the data in.
	     */
	    if (readresp >= 256) buffer[255] = '\0';
	    else buffer[readresp] = '\0';
	    if (mif_private->param[5]->element[0].bvalue) printf("Received back: %s\n", buffer);

	    /* Now we scan through the buffer setting each bit. At time 0.0
	     * or DC analysis, if a .ic was set, we only flip the bit if it
	     * was not undefined.
	     */
	    for(bitcnt = 0; buffer[bitcnt] != '\0' && buffer[bitcnt] != ' '
		  && bitcnt < tongspice_size; bitcnt = bitcnt + 1) {
	       if (buffer[bitcnt] == '1') tongspice[bitcnt] = ONE;
	       else if (buffer[bitcnt] == '0') tongspice[bitcnt] = ZERO;
	       else if (mif_private->circuit.anal_type != DC && mif_private->circuit.time != 0.0)
                  tongspice[bitcnt] = UNKNOWN;
	    }

	    /* If the result is short that means the remaining part was
	     * probably not touched or perhaps there was no update to return.
	     */
	 }
      }
   }

   /* If the communication channel died, we simply leave all ToNGSPICE
    * undefined.
    */
   else if (sendok && !commchannel->alive) {
      for(bitcnt = 0; bitcnt < tongspice_size; bitcnt = bitcnt + 1)
	 tongspice[bitcnt] = UNKNOWN;
   }

   /* Now we assign the outputs.  DC is quite simple as there is no time
    * step. For Transient, we need to look at the previous one to know if
    * it changed or not. */
   for(bitcnt = 0; bitcnt < tongspice_size; bitcnt = bitcnt + 1) {
      /* If the bit did not change we need to tag it as unchanged. We also
       * must do this if we sent no event to the digital side, as we did not
       * sample anything and therefore can't possibly have a change to
       * report.
       */
      if (!sendok || tongspice[bitcnt] == tongspice_old[bitcnt]) {
	 mif_private->conn[1]->port[bitcnt]->changed = FALSE;
      }
      /* For the other case, depending on the direction of the change we
       * either change add the rise or the fall delay.
       */
      else if (tongspice[bitcnt] == ONE) {
	 ((Digital_t*)(mif_private->conn[1]->port[bitcnt]->output.pvalue))->state = ONE;
	 mif_private->conn[1]->port[bitcnt]->delay = mif_private->param[3]->element[0].rvalue;
      }
      else if (tongspice[bitcnt] == ZERO) {
	 ((Digital_t*)(mif_private->conn[1]->port[bitcnt]->output.pvalue))->state = ZERO;
	 mif_private->conn[1]->port[bitcnt]->delay = mif_private->param[4]->element[0].rvalue;
      }
      else {
	 ((Digital_t*)(mif_private->conn[1]->port[bitcnt]->output.pvalue))->state = UNKNOWN;
	 if (tongspice_old[bitcnt] == ZERO)
	    mif_private->conn[1]->port[bitcnt]->delay = mif_private->param[3]->element[0].rvalue;
	 else mif_private->conn[1]->port[bitcnt]->delay = mif_private->param[4]->element[0].rvalue;
      }
   }
}
