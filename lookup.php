<?php

$dir = "data";
$suffix = "-7";
$no_test_data = 50;
$err_no = 0;
$errors = Array();

ini_set('memory_limit', -1);
$no = $argv[1];

if( ! preg_match('/^\d+$/', $no ) ) {
   die("how many lines of input should I use?  please specify on the command line");
}

if($no > 10000000) die("create more test data. I only have 10 million lines!");




foreach( array("input$suffix.txt", "positive$suffix.txt", "negative$suffix.txt")  as $filename ) {
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

$data = Array( 'php', $no );

$before = get_memory_usage();

$data[]=$before;


$hash = array();
$in = fopen( "$dir/input$suffix.txt", "r" ) or die("cannot read!");

$count = 0;
$counted = false;
while( $l = fgets($in) ){
  $l = rtrim($l);
  list($key, $value) = explode(' ', $l);

  
  $hash[$key] = $value;
  $count++;
  if( $count == $no - $no_test_data ) {
    $t0 = microtime(true);
    $counted = true;
  }
  if( $count >= $no ) break;
}
fclose($in);

if(! $counted) die("could not measure time to load last $no_test_data lines of data");

$t1 = microtime(true);
$t = $t1 - $t0;


$after = get_memory_usage();
$mem = $after - $before;
$data[]=$after;
$data[]=$mem;
$data[]=$t;


$in = fopen( "$dir/input$suffix.txt", "r" ) or die("cannot read!");
$count = 0;
$t0 = microtime(true);
while( $l = fgets($in) ){
  $l = rtrim($l);
  list($key, $value) = explode(' ', $l);

  
  $positive[] = $key;
  $count++;
  if( $count >= $no_test_data ) break;
}
fclose($in);


$negative = file("$dir/negative$suffix.txt", FILE_IGNORE_NEW_LINES) or die("cannot read negative!");

$max_repeat = 10000;

$data[]=$max_repeat;
$data[]=$no_test_data;

$t0 = microtime(true);
for ( $counter = 1; $counter <= $max_repeat; $counter += 1) {
  foreach( $positive as $l )  {
    if(! array_key_exists( $l, $hash ) ) {
      die("could not find $l!\n");
    }
  }
}
$t1 = microtime(true);
$t = $t1 - $t0;
$data[]=$t;


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

$data[]=$t;


echo( join($data, " ") );
echo( "\n" );
