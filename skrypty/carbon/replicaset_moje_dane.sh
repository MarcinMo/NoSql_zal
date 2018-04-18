#! /bin/bash
touch czas_rpl.csv

echo w1,j,:false >> czas_rpl.csv 
for(( i=1; i<=5; i++)) do
/usr/bin/time -f "%Uuser,%Ssystem,%Eelapsed" -o czas_rpl.csv -a gunzip -c 311_Cases.csv.gz | mongoimport --host carbon/localhost:27001,localhost:27002,localhost:27003 --drop -d test -c 311Cases --type csv --headerline --writeConcern '{w:1,j:false}'
sleep 5
done

echo w1,j,:true >> czas_rpl.csv 

for(( i=1; i<=5; i++)) do
/usr/bin/time -f "%Uuser,%Ssystem,%Eelapsed" -o czas_rpl.csv -a gunzip -c 311_Cases.csv.gz | mongoimport --host carbon/localhost:27001,localhost:27002,localhost:27003 --drop -d test -c 311Cases --type csv --headerline --writeConcern '{w:1,j:true}'
sleep 5
done
echo w2,j,:true >> czas_rpl.csv 
for(( i=1; i<=5; i++)) do
/usr/bin/time -f "%Uuser,%Ssystem,%Eelapsed" -o czas_rpl.csv -a gunzip -c 311_Cases.csv.gz | mongoimport --host carbon/localhost:27001,localhost:27002,localhost:27003 --drop -d test -c 311Cases --type csv --headerline --writeConcern '{w:2,j:true}'
sleep 5
done
echo w2,j,:false >> czas_rpl.csv 
for(( i=1; i<=5; i++)) do
/usr/bin/time -f "%Uuser,%Ssystem,%Eelapsed" -o czas_rpl.csv -a gunzip -c 311_Cases.csv.gz | mongoimport --host carbon/localhost:27001,localhost:27002,localhost:27003 --drop -d test -c 311Cases --type csv --headerline --writeConcern '{w:2,j:false}'
sleep 5
done

