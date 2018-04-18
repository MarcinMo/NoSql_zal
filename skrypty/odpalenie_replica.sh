#! /bin/bash
cd carbon
mongod --port 27001 --replSet carbon --dbpath data-1 --bind_ip localhost --oplogSize 128 --wiredTigerJournalCompressor zlib --wiredTigerCollectionBlockCompressor zlib > /dev/null &
sleep 10
mongod --port 27002 --replSet carbon --dbpath data-2 --bind_ip localhost --oplogSize 128 --wiredTigerJournalCompressor zlib --wiredTigerCollectionBlockCompressor zlib > /dev/null &
sleep 10
mongod --port 27003 --replSet carbon --dbpath data-3 --bind_ip localhost --oplogSize 128 --wiredTigerJournalCompressor zlib --wiredTigerCollectionBlockCompressor zlib > /dev/null &

sleep 10

mongo --host localhost:27001 repl_set_init.js 
sleep 10
./replicaset_moje_dane.sh
