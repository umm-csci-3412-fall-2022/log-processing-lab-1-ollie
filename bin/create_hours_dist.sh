#! /usr/bin/env bash

SCRATCH=$(mktemp --directory)
home=$(pwd)
cd "$1" || exit
cat "$home/html_components/hours_dist_header.html" > hours_dist.html
for f in $(ls -d */); do
        cat "$f/failed_login_data.txt" | awk '{ print $3 }' >> "$SCRATCH/listOfHours.txt"
done
sort "$SCRATCH/listOfHours.txt" | uniq -c | awk '{ print "data.addRow([\x27"$2"\x27, "$1"]);">> "hours_dist.html"}'
cat "$home/html_components/hours_dist_footer.html" >> hours_dist.html
