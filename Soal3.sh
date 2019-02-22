#!/bin/bash

i=1

fungsi_random() {
	ran=$(cat /dev/urandom | tr -dc a-zA-Z0-9 | fold -w 9 | head -n 1)
	num=$(cat /dev/urandom | tr -dc 0-9 | fold -w 1 | head -n 1)
	up=$(cat /dev/urandom | tr -dc A-Z | fold -w 1 | head -n 1)
	low=$(cat /dev/urandom | tr -dc a-z | fold -w 1 | head -n 1)
	key=($ran$num$up$low)
}

while [ -f /home/ismail/sisop/SoalShift_modul1_B13/password/password$i.txt ]
do
  let "i++"
done

fungsi_random
pass=1
while [[ "$pass" == 1 ]]
do
  for a in /home/ismail/sisop/SoalShift_modul1_B13/password/password*
  do
      if [[ "$key" == "$a" ]]
      then
        fungsi_random
        break
      fi
  done
  pass=0
done

echo $key > /home/ismail/sisop/SoalShift_modul1_B13/password/password$i.txt

