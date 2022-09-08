#! /usr/bin/env bash

cd"$1"
touch failed_login_data.txt
cd "/var/log"
cat * | awk '{if (match($0,/(... .. ..):..:.. \w+ ....\[.....\]: Failed password for invalid user (\w+) from ([0-9\.]*) .*/,groups)) {print group[1] " " group[2] " " group[3] >"failed_login_data.txt";}}'
