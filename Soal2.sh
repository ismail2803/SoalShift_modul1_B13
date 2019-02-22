
#!/bin/bash

echo "Negara dengan penjualan terbanyak"
negara=$(awk -F, '{if ($7==2012) {a[$1]+=$10}}END{for(i in a) print a[i]","i}' WA_Sales_Products_2012-14.csv | sort -n -r | awk -F, '{print $2}' | head -1)
echo "$negara"
printf "\n"

echo "Tiga product line dengan penjualan terbanyak negara $negara"
#awk -F, -v negara="$negara" '($1~negara) && ($7==2012){a[$4]+=$10}END{for(i in a) print a[i]","i}' WA_Sales_Products_2012-14.csv | sort -n -r | awk -F, '{print $2}' | head -3
produk=$(awk -F, -v negara="$negara" '($1~negara) && ($7==2012){a[$4]+=$10}END{for(i in a) print a[i]","i}' WA_Sales_Products_2012-14.csv | sort -n -r | awk -F, '{print $2}' | head -3)
pl1=$(echo "$produk" | awk 'NR==1 {print}')
echo "$pl1"
pl2=$(echo "$produk" | awk 'NR==2 {print}')
echo "$pl2"
pl3=$(echo "$produk" | awk 'NR==3 {print}')
echo "$pl3"
printf "\n"

echo "Tiga product dengan penjualan terbanyak berdasarkan tiga product line $pl1, $pl2, $pl3"
#awk -F,  '/United States/ && ($7==2012) && (/Outdoor Protection/ || /Camping Equipment/ || /Personal Accessories/){a[$6]+=$10}END{for(i in a) print a[i]","i}' WA_Sales_Products_2012-14.csv | sort -n -r | awk -F, '{print $2}' | head -3
awk -F, -v negara="$negara" -v pl1="$pl1" -v pl2="$pl2" -v pl3="$pl3" '($1~negara) && ($7==2012) && (($4~pl1) || ($4~pl2) || ($4~pl3)){a[$6]+=$10}END{for(i in a) print a[i]","i}' WA_Sales_Products_2012-14.csv | sort -n -r | awk -F, '{print $2}' | head -3
