#! /usr/bin/env bash


SCRATCH=$(mktemp --directory)
for file in "$1" "$2" "$3"
do
	tar -zxf "$file" --directory="$SCRATCH"
