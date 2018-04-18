#! /bin/bash
cd carbon
touch dane_czas.csv
mongod > /dev/null &

echo w1,l:false >> dane_czas.csv

for(( i=1; i<=5; i++)) do
/usr/bin/time -f "%Uuser,%Ssystem,%Eelapsed" -o dane_czas.csv -a gunzip -c ./311_Cases.csv.gz | mongoimport --drop -d nowa -c nowa --type csv --headerline --writeConcern '{w:1,j:false,wtimeout:500}'

done

echo w1,l:true >> dane_czas.csv

y=1
for(( i=1; i<=5; i++)); do
/usr/bin/time -f "%Uuser,%Ssystem,%Eelapsed" -o dane_czas.csv -a gunzip -c ./311_Cases.csv.gz | mongoimport --drop -d nowa -c nowa --type csv --headerline --writeConcern '{w:1,j:true,wtimeout:500}'

done
