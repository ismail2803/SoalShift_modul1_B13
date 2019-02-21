#!/bin/bash

awk '(NF<13) && /[cC][rR][oO][nN]/ && !/sudo/ {print}' /var/log/syslog > /home/ismail/modul1/logs.txt
