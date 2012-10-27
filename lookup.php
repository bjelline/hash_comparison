<?php

$dir = "data";

ini_set('memory_limit', -1);
$no = $argv[1];

if( ! preg_match('/^\-\w?\d+$/', $no ) ) {
   die("which input data set should I use?  please specify like this: -- -5 or -- -7");
}

$err_no = 0;
$errors = Array();



foreach( array("input$no.txt", "positive$no.txt", "negative$no.txt")  as $filename ) {
  if( ! is_file("$dir/$filename") ) {
    $err_no ++;
    $errors[] =  "cannot find file $filename in $dir.";
  }
}

if( $err_no > 0 ) {
  die("Fehlende Dateien: " . join("\n", $errors));
}

function get_memory_usage(){
  $pid = getmypid();
  return 0 + `ps -o rss= -p $pid`;
}

$before = get_memory_usage();

$t0 = microtime(true);

$hash = array();
$in = fopen( "$dir/input$no.txt", "r" ) or die("cannot read!");
while( $l = fgets($in) ){
  $l = rtrim($l);
  list($key, $value) = explode(' ', $l);

  
  $hash[$key] = $value;
}
fclose($in);

$t1 = microtime(true);
$t = $t1 - $t0;

print "READ: $t\n";

$after = get_memory_usage();
$mem = $after - $before;
print "MEM: $mem\n";


$positive = file("$dir/positive$no.txt", FILE_IGNORE_NEW_LINES) or die("cannot read positive!");
$negative = file("$dir/negative$no.txt", FILE_IGNORE_NEW_LINES) or die("cannot read negative!");


$t0 = microtime(true);
$max_repeat = 10000;
for ( $counter = 1; $counter <= $max_repeat; $counter += 1) {
  foreach( $positive as $l )  {
    if(! array_key_exists( $l, $hash ) ) {
      die("could not find $l!\n");
    }
  }
}
$t1 = microtime(true);
$t = $t1 - $t0;

print "POSITIVE: $t\n";

$t0 = microtime(true);
for ( $counter = 1; $counter <= $max_repeat; $counter += 1) {
  foreach( $negative as $l )  {
    if(array_key_exists( $l, $hash) ) {
      die("found $l!\n");
    }
  }
}
$t1 = microtime(true);
$t = $t1 - $t0;

print "NEGATIVE: $t\n";


