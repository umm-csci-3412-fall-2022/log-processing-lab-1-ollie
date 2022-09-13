#! /usr/bin/env bash

cd "$1" || exit
touch failed_login_data.txt
cd "var/log" || exit
cat --* | awk '{if (match($0,/(... .. ..):..:.. \w+ ....\[.?....\]: Failed password for (invalid user )?(\w+) from ([0-9\.]*) .*/,group)) {print group[1] " " group[3] " " group[4]>>"../../failed_login_data.txt";}}'
