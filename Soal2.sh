#!/bin/bash

echo "Negara dengan penjualan terbanyak"
negara=$(awk -F, '/2012/{a[$1]+=$10}END{for(i in a) print a[i]",",i}' WA_Sales_Products_2012-14.csv | sort -n -r | awk -F, '{print $2}' | head -1)
echo "$negara"
printf "\n"

echo "Tiga product line dengan penjualan terbanyak negara$negara"
awk -F, '/United States/ && ($7==2012){a[$4]+=$10}END{for(i in a) print a[i]",",i}' WA_Sales_Products_2012-14.csv | sort -n -r | awk -F, '{print $2}' | head -3
printf "\n"

echo "Tiga product dengan penjualan terbanyak pada Personal Accessories"
awk -F, '/Personal Accessories/ && /United States/ && ($7==2012){a[$6]+=$10}END{for(i in a) print a[i]",",i}' WA_Sales_Products_2012-14.csv | sort -n -r | awk -F, '{print $2}' | head -3
printf "\n"

echo "Tiga product dengan penjualan terbanyak pada Camping Equipment"
awk -F, '/Camping Equipment/ && /United States/ && ($7==2012){a[$6]+=$10}END{for(i in a) print a[i]",",i}' WA_Sales_Products_2012-14.csv | sort -n -r | awk -F, '{print $2}' | head -3
printf "\n"

echo "Tiga product dengan penjualan terbanyak pada Outdoor Protection"
awk -F, '/Outdoor Protection/ && /United States/ && ($7==2012){a[$6]+=$10}END{for(i in a) print a[i]",",i}' WA_Sales_Products_2012-14.csv | sort -n -r | awk -F, '{print $2}' | head -3
printf "\n"
