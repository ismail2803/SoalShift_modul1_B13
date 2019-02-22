#!/bin/bash

#!/bin/bash

Jam=$(echo "$1" | awk -F: '{print $1}')

Hbesar="ABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZ"
Hkecil="abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyz"

cat "$1" | tr "${Hbesar:$Jam:26}${Hkecil:$Jam:26}" "${Hbesar:0:26}${Hkecil:0:26}" > /home/ismail/sisop/SoalShift_modul1_B13/backup/"$1.dec"

