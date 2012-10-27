#!/usr/bin/perl

use  Time::HiRes ('time');

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

sub get_memory_usage {
  0 + `ps -o rss= -p $$`
}

$before = get_memory_usage();

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
$after = get_memory_usage();

$mem = $after - $before;

print "READ: $t\n";
print "MEM: $mem\n";



open($in, "$dir/positive$no.txt") or die("cannot read!");
@positive = <$in>;
chomp(@positive);
close($in);

open($in, "$dir/negative$no.txt") or die("cannot read!");
@negative = <$in>;
chomp(@negative);
close($in);

$max_repeat = 10000;

$t0 = time();
for ( $counter = 1; $counter <= $max_repeat; $counter += 1) {
    foreach ( @positive )  {
      if(! defined $hash{$_} ) {
        die "could not find $_!\n";
      }
    }
}
$t1 = time();
$t = $t1 - $t0;

print "POSITIVE: $t\n";


$t0 = time();
for ( $counter = 1; $counter <= $max_repeat; $counter += 1) {
  foreach ( @negative )  {
    if(defined $hash{$_} ) {
      die("found $_!\n");
    }
  }
}
$t1 = time();
$t = $t1 - $t0;

print "NEGATIVE: $t\n";


