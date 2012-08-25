#!/usr/bin/perl

use  Time::HiRes;

$dir = "data";

$no = shift @ARGV;

die("which data set should I use? please specify like this: -5 or -7")
  unless $no =~ m/^\-\d+$/;

$err_no = 0;
@errors = ();

foreach $filename ( ("input$no.txt", "positive$no.txt", "negative$no.txt") ) {
  if( ! -r "$dir/$filename" ) {
    $err_no ++;
    push(@errors, "Kann die Datei $filename nicht finden.");
  }
}

if( $err_no > 0 ) {
  die("Fehlende Dateien: " . join("\n", @errors));
}


$t0 = time();

open($in, "$dir/input$no.txt") or die("cannot read!");
while(<$in>){
  chomp;
  ($key, $value) = split / /;
  $hash{$key} = $value;
}
close($in);

$t1 = time();
$t = $t1 - $t0;

print "READ: $t\n";


$t0 = time();

open($in, "$dir/positive$no.txt") or die("cannot read!");
while(<$in>){
  chomp;
  if(! defined $hash{$_} ) {
    print STDERR "could not find $_!\n";
  }
}
close($in);

$t1 = time();
$t = $t1 - $t0;

print "POSITIVE: $t\n";



$t0 = time();

open($in, "$dir/negative$no.txt") or die("cannot read!");
while(<$in>){
  chomp;
  if(defined $hash{$_} ) {
    die("found $_!\n");
  }
}
close($in);

$t1 = time();
$t = $t1 - $t0;

print "NEGATIVE: $t\n";


