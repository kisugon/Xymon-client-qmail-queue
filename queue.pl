#!/usr/local/bin/perl

## Xymon client qmail queue
## Copyright (c) 2013 Keisuke Akiyama
## This software is released under the MIT License.

$bb = $ENV{"BB"} || die "BB not defined";
$bbdisp = $ENV{"BBDISP"} || die "BBDISP not defined";
$hostname = "";
$hobbitcolumn = "queue";
$color="green";
$summary = "OK";
$threshold = 500;
$msg = "";

open(COM, "/var/qmail/bin/qmail-qstat |");
while (<COM>){
  $msg .= $_;
  /^messages in queue:\s*(\d+)$/;
  $value = $1;
}

if ($value >= $threshold) {
  $color = "red";
  $summary = "NG";
}

system($bb." ".$bbdisp." \"status ".$hostname.".".$hobbitcolumn." ".$color." ".$summary."\n\n".$msg."\"");
