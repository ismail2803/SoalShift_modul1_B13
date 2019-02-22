#!/bin/bash

cd /home/ismail/sisop/SoalShift_modul1_B13
unzip nature.zip

for eachfile in /home/ismail/sisop/SoalShift_modul1_B13/nature/*
do
  base64 -d $eachfile | xxd -r > $eachfile'2'
  rm $eachfile
  mv $eachfile'2' $eachfile
done

