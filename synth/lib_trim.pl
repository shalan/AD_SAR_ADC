# This Script removes specified input cells ARGV[1] from the lib file input ARGV [0]

use warnings;
use strict;
use feature "switch";
#use experimental qw( switch );
open( CF , $ARGV[1] ) or die("Couldn't open $ARGV[1]");
my @cells = ();
while(<CF>){ #cells to remove
  next if (/\#/);
  chop($_);
  push @cells, $_;
}
close(CF);

my $state = 0;
my $count = 0;
for ($ARGV[0]) {
  for (split) {
    open (LIB, $_) or die("Couldn't open $_");

    while(my $line=<LIB>){
      given ($state) {
        when ($state==0){
          #print $line;
          if ($line =~ /cell\s*\(\"?(.*?)\"?\)/) {
            #print "$1\n";
            if (grep { $_ eq $1 } @cells) {
              $state = 2;
              print "/* removed $1 */\n";
            } else {
              $state = 1;
              print $line;
            }
            $count = 1;
          } else {
            print $line;
          }
        }

        when($state==1){
          $count++ if ($line =~ /\{/);
          $count-- if ($line =~ /\}/);
          $state = 0 if($count==0);
          print $line;
        }


        when($state==2){
          $count++ if ($line =~ /\{/);
          $count-- if ($line =~ /\}/);
          $state = 0 if($count==0);
        }


      }
    }

    close(LIB);
  }
}