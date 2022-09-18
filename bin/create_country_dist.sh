#! /usr/bin/env bash

SCRATCH=$(mktemp --directory)
home=$(pwd)
cd "$1" || exit
cat "$home/html_components/country_dist_header.html" > country_dist.html
for f in $(ls -d */); do
        cat "$f/failed_login_data.txt" | awk '{ print $5 }' >> "$SCRATCH/listOfIP.txt"
done
sort "$SCRATCH/listOfIP.txt" | join -o 1.2 "$home/etc/country_IP_map.txt"  - | sort | uniq -c | awk '{ print "data.addRow([\x27"$2"\x27, "$1"]);">> "country_dist.html"}'
cat "$home/html_components/country_dist_footer.html" >> country_dist.html

