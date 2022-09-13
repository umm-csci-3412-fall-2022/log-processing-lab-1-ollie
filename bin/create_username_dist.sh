#! /usr/bin/env bash

cd "$1" || exit
name=0;
namecount=0;
sort failed_login_data.txt

| awk '{if (match($0,//,group)) {print group[1] " " group[3] " " group[4]>>"../../failed_login_data.txt";}}'
