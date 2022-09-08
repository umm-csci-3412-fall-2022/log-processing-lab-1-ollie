#! /usr/bin/env bash


contents=$1
nameSpec=$2
nameLoc=$3
header="_header.html"
blankheader="$nameSpec$header"
footer="_footer.html"
blankfooter="$nameSpec$footer"
cat "$blankheader" > "$nameLoc"
cat "$contents" >> "$nameLoc"
cat "$blankfooter" >> "$nameLoc"
