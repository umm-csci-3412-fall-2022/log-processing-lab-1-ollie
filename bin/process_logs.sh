#! /usr/bin/env bash


SCRATCH=$(mktemp --directory)
for file in "$@" # for each dir passed, find it's basename make a directory in temp with basename, extract there, and proccess client logs at that place.
do
	dirFile=$(basename "$file" .tgz)
	mkdir "$SCRATCH/$dirFile"
	tar -zxf "$file" --directory="$SCRATCH/$dirFile"
	"bin/process_client_logs.sh" "$SCRATCH/$dirFile"
	
done
bin/create_username_dist.sh "$SCRATCH" # run bash at those locations.
bin/create_hours_dist.sh "$SCRATCH"
bin/create_country_dist.sh "$SCRATCH"
bin/assemble_report.sh "$SCRATCH"
mv "$SCRATCH/failed_login_summary.html" . # move final product to here (.)
