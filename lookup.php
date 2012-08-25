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


$t0 = time();

$hash = array();
$in = fopen( "$dir/input$no.txt", "r" ) or die("cannot read!");
while( $l = fgets($in) ){
  $l = rtrim($l);
  list($key, $value) = explode(' ', $l);

  
  $hash[$key] = $value;
}
fclose($in);

$t1 = time();
$t = $t1 - $t0;

print "READ: $t\n";

print "MEM: " . floor((memory_get_usage() / 1024)/1024) . "MB \n";

$t0 = time();

$in = fopen("$dir/positive$no.txt", "r") or die("cannot read!");
while($l = fgets($in)){
  $l = rtrim($l);
  if(! array_key_exists( $l, $hash ) ) {
    print "could not find $l!\n";
  }
}
fclose($in);

$t1 = time();
$t = $t1 - $t0;

print "POSITIVE: $t\n";



$t0 = time();

$in = fopen("$dir/negative$no.txt", "r") or die("cannot read!");
while( $l = fgets($in) ){
  $l = rtrim($l);
  if(array_key_exists( $l, $hash) ) {
    die("found $l!\n");
  }
}
fclose($in);

$t1 = time();
$t = $t1 - $t0;

print "NEGATIVE: $t\n";


