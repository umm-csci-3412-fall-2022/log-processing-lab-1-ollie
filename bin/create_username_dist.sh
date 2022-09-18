#! /usr/bin/env bash

SCRATCH=$(mktemp --directory) 
home=$(pwd)
cd "$1" || exit
cat "$home/html_components/username_dist_header.html" > username_dist.html
for f in $(ls -d */); do
	cat "$f/failed_login_data.txt" | awk '{ print $4 }' >> "$SCRATCH/listOfNames.txt"
done
sort "$SCRATCH/listOfNames.txt" | uniq -c | awk '{ print "data.addRow([\x27"$2"\x27, "$1"]);">> "username_dist.html"}' 
cat "$home/html_components/username_dist_footer.html" >> username_dist.html

