#! /bin/bash
cd carbon

curl https://data.sfgov.org/api/views/vw6y-z8j6/rows.csv?accessType=DOWNLOAD > 311_Cases.csv

gzip 311_Cases.csv

