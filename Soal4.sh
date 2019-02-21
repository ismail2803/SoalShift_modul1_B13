#!/bin/bash

Waktu=$(date '+%H:%M %d-%m-%Y')
Jam=$(date '+%H')

Hbesar="ABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZ"
Hkecil="abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyz"

awk '{print}' /var/log/syslog | tr "${Hbesar:0:26}${Hkecil:0:26}" "${Hbesar:$Jam:26}${Hkecil:$Jam:26}" > /home/ismail/sisop/SoalShift_modul1_B13/backup/"$Waktu.txt"
