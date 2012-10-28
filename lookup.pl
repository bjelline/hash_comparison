#
# lookup.pl - Memory and Performance Test for Perl Hashes
#
=begin COMMENT

 Copyright (C) 2012 Brigitte Jellinek <code@brigitte-jellinek.at>

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU Affero General Public License as
    published by the Free Software Foundation, either version 3 of the
    License, or (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU Affero General Public License for more details.

    You should have received a copy of the GNU Affero General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.

=end COMMENT

=cut

use Time::HiRes ('time');
use File::Basename;

my $dirname = dirname(__FILE__);  # absolute path of this program
my $dir     = "$dirname/data";    # absolute path of data
my $err_no = 0;
my @errors = ();

my $no = shift @ARGV;    # size of hash
my $no_test_data = 50;   # no of keys/values to read 
my $max_repeat = 10000;  # no of repetitions of read operation (times no_test_data)


die("how many lines of data set should I use? please specify on the commandline")
  unless $no =~ m/^\d+$/;

die("create more test data. I only have 10 million lines!")
  if $no > 10000000;


foreach $filename ( ("input.txt", "negative.txt") ) {
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
open(my $in, "$dir/input.txt") or die("cannot read!");

$counted = 0;
while(<$in>){
  chomp;
  ($key, $value) = split / /;
  $hash{$key} = $value;
  $count++;
  last if $count >= $no;
  # only count the last 50 inserts - when most of the has is already loaded
  if( $count + $no_test_data == $no ) {
    $counted = 1;
     $t0 = time();
  }
}
$t1 = time();
close($in);

die("could not measure the time to load last $no_test_data lines of data") unless $counted;

$t = $t1 - $t0;
$after = get_memory_usage();

push(@data, $after);
push(@data, $after - $before);
push(@data, $t);


push(@data, $max_repeat);
push(@data, $no_test_data);


open($in, "$dir/input.txt") or die("cannot read!");
$count = 0;
while( <$in> ) {
  my($key, $value) = split / /;
  push(@positive, $key);
  $count++;
  last if $count >= $no_test_data
}
close($in);

open($in, "$dir/negative.txt") or die("cannot read!");
@negative = <$in>;
chomp(@negative);
close($in);

die("i need $no_test_data lines of negative examples, not " +
  scalar(@negative) ) if scalar(@negative) != $no_test_data ;

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

print join(" ", @data) . "\n";

