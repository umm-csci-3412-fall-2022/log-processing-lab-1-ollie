#! /usr/bin/env bash

SCRATCH=$(mktemp --directory)
home=$(pwd)
cd "$1" || exit
cat "$home/html_components/country_dist_header.html" > country_dist.html
for f in */; do
        [[ -e "$f" ]] || break 
	awk '{ print $5 }' "$f/failed_login_data.txt" >> "$SCRATCH/listOfIP.txt"  # for every file find failed.txt and print ip into temp text file

done
sort "$SCRATCH/listOfIP.txt" | join -o 1.2 "$home/etc/country_IP_map.txt"  - | sort | uniq -c | awk '{ print "data.addRow([\x27"$2"\x27, "$1"]);">> "country_dist.html"}'
# sort temp.txt, join that with IP_map.txt but just return the second value (country code) from the first file (IP_map). sort that again because not all ip have same country, count and print country code then #.
cat "$home/html_components/country_dist_footer.html" >> country_dist.html

