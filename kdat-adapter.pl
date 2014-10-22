#!/usr/bin/perl
# Kdat adapter
#If used escape these characters . * ? + [ ] ( ) { } ^ $ | \ ;
#The 's' RE modifier makes it work on more than one line by default.

use strict;
use warnings;

my $file = 'true_p1.txt';

open INPUT, '<', $file or warn;
my @input_array=<INPUT>;
close(INPUT);
my $file_code=join("",@input_array);
#$file_code =~ s#KA#K1#g; #Be careful with the 's' RE modifier. 
$file_code =~ s#(st.*\n)KA\;#$1K1;#g; #Be careful with the 's' RE modifier. 
open OUTPUT, '>', $file or warn;
print(OUTPUT $file_code);
close(OUTPUT);