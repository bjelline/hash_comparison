#!/usr/bin/perl

use Time::HiRes ('time');

$dir = "data";
$err_no = 0;
@errors = ();
$suffix = "-7";

$no = shift @ARGV;

die("how many lines of data set should I use? please specify on the commandline")
  unless $no =~ m/^\d+$/;

die("create more test data. I only have 1 million lines!")
  if $no > 1000000;


foreach $filename ( ("input$suffix.txt", "positive$suffix.txt", "negative$suffix.txt") ) {
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
@data = ("perl", $no, $before);


$count = 0;
open($in, "$dir/input$suffix.txt") or die("cannot read!");

$t0 = time();
while(<$in>){
  chomp;
  ($key, $value) = split / /;
  $hash{$key} = $value;
  $count++;
  last if $count >= $no;
}
$t1 = time();
close($in);

$t = $t1 - $t0;
$after = get_memory_usage();

push(@data, $after);
push(@data, $after - $before);
push(@data, $t);

$no_of_test_data = 50;
$max_repeat = 10000;

push(@data, $max_repeat);
push(@data, $no_of_test_data);


open($in, "$dir/input$suffix.txt") or die("cannot read!");
$count = 0;
while( <$in> ) {
  my($key, $value) = split / /;
  push(@positive, $key);
  $count++;
  last if $count >= $no_of_test_data
}
close($in);

open($in, "$dir/negative$suffix.txt") or die("cannot read!");
@negative = <$in>;
chomp(@negative);
close($in);

die("i need $no_of_test_data lines of negative examples, not " +
  scalar(@negative) ) if scalar(@negative) != $no_of_test_data ;

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

push(@data, $t);


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

push(@data, $t);

print join(";", @data) . "\n";

