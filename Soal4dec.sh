#!/bin/bash

#!/bin/bash

Waktu=$(date '+%H:%M %d-%m-%Y')
echo "Masukkan Jam Enkripsi"
read Jam

Hbesar="ABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZ"
Hkecil="abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyz"

cat "$1" | tr "${Hbesar:$Jam:26}${Hkecil:$Jam:26}" "${Hbesar:0:26}${Hkecil:0:26}" > /home/ismail/sisop/SoalShift_modul1_B13/backup/"decrypt$Jam.txt"

