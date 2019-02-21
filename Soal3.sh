#!/bin/bash

i=1
key=$(cat /dev/urandom | tr -dc a-zA-Z0-9 | fold -w 12 | head -n 1)

while [ -f /home/ismail/sisop/SoalShift_modul1_B13/password/password$i.txt ]
do
  if [[ $key ==  password$i.txt ]]
  then
   key=$(cat /dev/urandom | tr -dc a-zA-Z0-9 | fold -w 12 | head -n 1)
   i=1
  else
    let "i++"
  fi
done

echo $key > /home/ismail/sisop/SoalShift_modul1_B13/password/password$i.txt

