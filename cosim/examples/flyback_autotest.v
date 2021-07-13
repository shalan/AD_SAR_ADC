////////////////////////////////////////////////////////////////////////////////
// Flyback Testbench
////////////////////////////////////////////////////////////////////////////////
// This is a testbench to make sure the flyback reaches the desired level.
////////////////////////////////////////////////////////////////////////////////

`timescale 1ns/1ns

module flyback_autotest;

time delay;

// We first connect the HDL to the analog domain
reg [5:0] adc;
reg d_osc;
reg d_clk;

initial
begin
   $d_hdl_sync("simulator_pipe",
      "/usr/local/bin/ngspice -b -r flyback_autotest.raw flyback_autotest.sp",
      d_osc, adc, d_clk);
end

// We set the output oscilator to be a clock with variable dutycycle
initial
begin
   d_osc = 1'b0;
   #100;
   forever
   begin
      d_osc = 1'b1;
      #(delay) d_osc = 1'b0;
      #(10_000-delay);
   end
end

task test_flyback_within(input integer low, input integer high,
   input time interval);
begin
   $display("Checking Flyback... @%0t within %0dV and %0dV for %0tns",
      $time, low, high, interval);
   if (adc < low || adc > high)
      $display("ERROR: flyback not in range @%0tns", $time);
   else
   begin
      fork
	 begin: WAITBRANCH
	    wait(adc < low || adc > high);
	    $display("ERROR: flyback did not remain within the range @%0tns",
	       $time);
	    disable DELAYBRANCH;
	 end
	 begin: DELAYBRANCH
	    #(interval);
	    $display("SUCCESS: flyback is in the range @%0tns", $time);
	    disable WAITBRANCH;
	 end
      join
   end
end
endtask

// Now we do our test.
initial
begin
   delay = 1_500; // D=0.15
   #400_000;
   test_flyback_within(2, 4, 100_000);
   delay = 5_000; // D=0.5
   #400_000;
   test_flyback_within(9, 11, 100_000);
   delay = 7_500; // D=0.75
   #800_000;
   test_flyback_within(27, 32, 100_000);

   /* There is no finish, we let the $d_hdl end the simulation. */
end

// And we generate a VCD file so we can look at the results
initial
begin
   $dumpfile("waves.vcd");
   $dumpvars(0, flyback_autotest);
end

endmodule
