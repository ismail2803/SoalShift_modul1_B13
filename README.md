## Soal 1
Anda diminta tolong oleh teman anda untuk mengembalikan filenya yang telah dienkripsi oleh seseorang menggunakan bash script, file yang dimaksud adalah nature.zip. Karena terlalu mudah kalian memberikan syarat akan membuka seluruh file tersebut jika pukul 14:14 pada tanggal 14 Februari atau hari tersebut adalah hari jumat pada bulan Februari.
Hint: Base64, Hexdump

#### Penyelesaian
Pertama unzip file nature.zip dengan perintah
```
unzip.nature
```
isi dari folder nature adalah file-file .jpg tetapi tidak bisa dibuka karena terenkripsi. file-file tersebut dienkripsi menggunakan base64. Untuk mendekripsinya gunakan perintah
```
base 64 -d file_input > file_output
```
Setelah file didekripsi file tersebut masih dalam tampilan heksadesimal. Untuk mengembalikan ke bentuk awalnya, gunakan perintah
```
xxd -r file_input > file_output
```
#### script
```
#!/bin/bash

unzip nature.zip

for eachfile in /home/ismail/sisop/SoalShift_modul1_B13/nature/*
do
base64 -d $eachfile | xxd -r > $eachfile'2'
rm $eachfile
mv $eachfile'2' $eachfile
done
```
 - ``` #!/bin/bash ``` Untuk Memberitahu sistem bahwa perintah ini dijalankan oleh bash
 - ```  unzip nature.zip ``` Untuk mengekstrak file nature.zip
 - ```  for eachfile in /home/ismail/sisop/SoalShift_modul1_B13/nature/* ``` Untuk setiap file di directory tersebut
 - ``` base64 -d $eachfile | xxd -r > $eachfile'2' ``` file akan didekripsi menggunakan base64 lalu mengubah tampilannya menggunakan Hexdump dan hasil output dikirim ke file ``` $eachfile'2' ```

Crontab
```
14 14 14 2 * /bin/bash /home/ismail/sisop/SoalShift_modul1_B13/Soal1.sh
0 0 * 2 5 /bin/bash /home/ismail/sisop/SoalShift_modul1_B13/Soal1.sh
```
## Soal 2
Anda merupakan pegawai magang pada sebuah perusahaan retail, dan anda diminta untuk memberikan laporan berdasarkan file WA_Sales_Products_2012-14.csv.
Laporan yang diminta berupa:
a. Tentukan negara dengan penjualan(quantity) terbanyak pada tahun 2012.
b. Tentukan tiga product line yang memberikan penjualan(quantity) terbanyak pada soal poin a.
c. Tentukan tiga product yang memberikan penjualan(quantity) terbanyak berdasarkan tiga product line yang didapatkan pada soal poin b.

#### Penyelesaian
##### Soal a
``` awk -F, '/2012/{a[$1]+=$10}END{for(i in a) print a[i]",",i}' WA_Sales_Products_2012-14.csv | sort -n -r | awk -F, '{print $2}' | head -1) ```

 - ``` -F, ``` untuk memberitahu awk bahwa separator tiap kolom dari data adalah koma (,)
 - ``` /2012/ ``` mencari record yang mengandung "2012"
 - ``` {a[$1]+=$10} ``` menjumlahkan quantity kolom ke sepuluh dari array a yang memiliki indeks yang sama
 - ``` END{for(i in a) print a[i]",",i} ``` melakukan looping sebanyak index array a dan mencetak isi dari index dan index tersebut.
 - ``` WA_Sales_Products_2012-14.csv ``` file inputan
 - ``` sort -n -r ``` mengurutkan ouput berdasarkan nilai numerik (-n) dan membalikkan hasil pengurutan dari ascending menjadi descending (-r)
 - ``` awk -F, '{print $2}' ```mencetak kolom kedua hasil perintah sebelumnya
 - ``` head -1 ``` mencetak urutan teratas hasil perintah sebelumnya
##### Soal b
``` awk -F, '/United States/ && ($7==2012){a[$4]+=$10}END{for(i in a) print a[i]",",i}' WA_Sales_Products_2012-14.csv | sort -n -r | awk -F, '{print $2}' | head -3 ```

 - ``` /United States/ ``` mencari record yang mengandung "United States"
 - ``` ($7==2012) ``` mengecek record-record pada kolom 7 yang mengandung 2012
 - ``` head -3 ``` mencetak 3 urutan teratas hasil perintah sebelumnya
##### Soal c
```
awk -F, '/Personal Accessories/ && /United States/ && ($7==2012){a[$6]+=$10}END{for(i in a) print a[i]",",i}' WA_Sales_Products_2012-14.csv | sort -n -r | awk -F, '{print $2}' | head -3
awk -F, '/Camping Equipment/ && /United States/ && ($7==2012){a[$6]+=$10}END{for(i in a) print a[i]",",i}' WA_Sales_Products_2012-14.csv | sort -n -r | awk -F, '{print $2}' | head -3
awk -F, '/Outdoor Protection/ && /United States/ && ($7==2012){a[$6]+=$10}END{for(i in a) print a[i]",",i}' WA_Sales_Products_2012-14.csv | sort -n -r | awk -F, '{print $2}' | head -3
```
## Soal 3
Buatlah sebuah script bash yang dapat menghasilkan
password secara acak sebanyak 12 karakter yang terdapat huruf besar, huruf kecil, dan angka. Password acak tersebut disimpan pada file berekstensi .txt dengan ketentuan pemberian nama sebagai berikut:
a. Jika tidak ditemukan file password1.txt maka password acak tersebut disimpan pada file bernama password1.txt
b. Jika file password1.txt sudah ada maka password acak baru akan disimpan pada file bernama password2.txt dan begitu seterusnya.
c. Urutan nama file tidak boleh ada yang terlewatkan meski filenya dihapus.
d. Password yang dihasilkan tidak boleh sama.

#### Penyelesaian
```
#!/bin/bash
i=1

key=$(cat /dev/urandom | tr -dc a-zA-Z0-9 | fold -w 12 | head -n 1)

while [ -f /home/ismail/sisop/SoalShift_modul1_B13/password/password$i.txt ]
do
  if [[ $key == password$i.txt ]]
  then
    key=$(cat /dev/urandom | tr -dc a-zA-Z0-9 | fold -w 12 | head -n 1)
    i=1
  else
    let "i++"
  fi
done

echo $key > /home/ismail/sisop/SoalShift_modul1_B13/password/password$i.txt
```

 - ``` i=1 ``` inisialisasi variabel i
 - ``` key=$(cat /dev/urandom | tr -dc a-zA-Z0-9 | fold -w 12 | head -n 1) ``` mengisi variabel key dengan ouput dari perintah didalamnya. ``` cat /dev/urandom``` mencetak isi dari /dev/urandom.  ``` tr -dc a-zA-Z0-9 ``` untuk mengambil karakter a-z, A-Z, 0-9 dari output perintah sebelumya. ``` fold -w 12 ``` mengambil 12 karakter hasil output perintah sebelumnya. ``` head -n 1 ``` mencetak 1 teratas hasil output perintah sebelumnya.
 - ``` while [ -f /home/ismail/sisop/SoalShift_modul1_B13/password/password$i.txt ] ``` selama ada file ```password$i.txt``` didalam directory tersebut
``` 
if [[ $key == password$i.txt ]]
  then
    key=$(cat /dev/urandom | tr -dc a-zA-Z0-9 | fold -w 12 | head -n 1)
    i=1
  else
    let "i++"
  fi
 ```
 - Mengecek key yang baru dibuat apakah sama dengan password pada file yang ada. jika sama maka akan dibuat key baru lagi dan nilai i=1. Jika todak, maka maka nilai i akan ditambah 1.
 -  ``` echo $key > /home/ismai/siso/SoalShift_modul1_B13/password/password$i.txt ``` Jika while diatas sudah tidak terpenuhi maka key tersebut akan dikirimkan ke file    password$i.txt
## Soal 4
Lakukan backup file syslog setiap jam dengan format nama file “jam:menit tanggal-bulan-tahun”. Isi dari file backup terenkripsi dengan konversi huruf (string manipulation) yang disesuaikan dengan jam dilakukannya backup misalkan sebagai berikut:
a. Huruf b adalah alfabet kedua, sedangkan saat ini waktu menunjukkan pukul 12, sehingga huruf b diganti dengan huruf alfabet yang memiliki urutan ke 12+2 = 14.
b. Hasilnya huruf b menjadi huruf n karena huruf n adalah huruf ke empat belas, dan seterusnya.
c. setelah huruf z akan kembali ke huruf a
d. Backup file syslog setiap jam.
e. dan buatkan juga bash script untuk dekripsinya.

#### Penyelesaian
```
#!/bin/bash

Waktu=$(date '+%H:%M %d-%m-%Y')
Jam=$(date '+%H')
Hbesar="ABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZ"
Hkecil="abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyz"

awk '{print}' /var/log/syslog | tr "${Hbesar:0:26}${Hkecil:0:26}" "${Hbesar:$Jam:26}${Hkecil:$Jam:26}" > /home/ismail/sisop/SoalShift_modul1_B13/backup/"$Waktu.txt"
```

 - ``` Waktu=$(date '+%H:%M %d-%m-%Y') ``` mengambil waktu saat ini
 - ``` Jam=$(date '+%H') ``` mengambil jam saat ini
 - ``` Hbesar="ABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZ" ``` menyimpan string upper case abjad A-Z
 - ``` Hkecil="abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyz" ``` menyimpan string lower case abjad a-z
 - ``` awk '{print}' /var/log/syslog ``` mencetak file syslog
```
tr "${Hbesar:0:26}${Hkecil:0:26}" "${Hbesar:$Jam:26}${Hkecil:$Jam:26}" > /home/ismail/sisop/SoalShift_modul1_B13/backup/"$Waktu.txt" 
```
 - output hasil perintah sebelumnya, setiap karakter akan di transform (setiap karakter abjad akan di geser sebesar jam saat bash dijalankan) dan  hasilnya dikirimkan ke file $waktu.txt yaitu jam saat script dijalankan.

Crontab
```
*/60 * * * * /bin/bash /home/ismail/sisop/SoalShift_modul1_B13/Soal4.sh
```

## Soal 5
Buatlah sebuah script bash untuk menyimpan record dalam syslog yang memenuhi kriteria berikut:
a. Tidak mengandung string “sudo”, tetapi mengandung string “cron”, serta buatlah pencarian stringnya tidak bersifat case sensitive, sehingga huruf kapital atau tidak, tidak menjadi masalah.
b. Jumlah field (number of field) pada baris tersebut berjumlah kurang dari 13.
c. Masukkan record tadi ke dalam file logs yang berada pada direktori /home/[user]/modul1.
d. Jalankan script tadi setiap 6 menit dari menit ke 2 hingga 30, contoh 13:02, 13:08, 13:14, dst.
#### Penyelesaian
```
#!/bin/bash

awk '(NF<13) && /[cC][rR][oO][nN]/ && !/sudo/ {print}' /var/log/syslog > /home/ismail/modul1/logs.txt
```

 - ``` (NF<13) ``` Number of Field kurang dari 13
```
/[cC][rR][oO][nN]/ && !/sudo/ {print}' /var/log/syslog > /home/ismail/modul1/logs.txt 
```
 - Mencari Record yang mengandung cron (tidak case-sensitive) tetapi tidak mengandung sudo. hasil output akan dikirim ke file /home/ismail/modul1/logs.txt 

Crontab
```
2-30/6 * * * * /bin/bash /home/ismail/sisop/SoalShift_modul1_B13/Soal5.sh
```

