use warnings;
use strict;
use feature "switch";
#use experimental qw( switch );
die "Usage: $0 file.v \n" if @ARGV < 1;
open( CF , $ARGV[0] ) or die("Couldn't open $ARGV[0]");
while(my $line=<CF>){
    my $tmp = $line;
    $tmp=~ s/^\s+//;
    chomp($line);
    if(($tmp =~ /^\)\;/)) {
        print "    , .VGND(VGND), .VNB(VNB), .VPB(VPB), .VPWR(VPWR)\n";
        print $line;
    } elsif ($tmp =~ /^module/) {
        chop($line);
        chop($line);
        print "$line, VGND, VNB, VPB, VPWR);\n";
        print "  input  VPWR;\n";
        print "  input  VGND;\n";
        print "  input  VPB ;\n";
        print "  input  VNB ;";
    } else {
        print $line;
    }
    print "\n";
    
}
close(CF);