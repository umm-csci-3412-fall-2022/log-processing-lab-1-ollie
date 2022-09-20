#! /usr/bin/env bash

SCRATCH=$(mktemp --directory)
home=$(pwd)
cd "$1" || exit
cat "$home/html_components/hours_dist_header.html" > hours_dist.html
for f in  */; do
	[[ -e "$f" ]] || break
	awk '{ print $3 }' "$f/failed_login_data.txt" >> "$SCRATCH/listOfHours.txt" # for each file, find failed, print hour ($3)
done
sort "$SCRATCH/listOfHours.txt" | uniq -c | awk '{ print "data.addRow([\x27"$2"\x27, "$1"]);">> "hours_dist.html"}' # sort, find unique and count, print hour, #
cat "$home/html_components/hours_dist_footer.html" >> hours_dist.html
