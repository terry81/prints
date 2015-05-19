#!/usr/bin/perl
# Kdat adapter

use strict;
use warnings;

my $file = 'true_p.txt';

open INPUT, '<', $file or warn;
my @input_array=<INPUT>;
close(INPUT);
my $file_code=join("",@input_array);
$file_code =~ s#(st.*\n)KA\;#$1K1;#g;
open OUTPUT, '>', $file or warn;
print(OUTPUT $file_code);
close(OUTPUT);
