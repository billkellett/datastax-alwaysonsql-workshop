#!/bin/bash

echo "Begin loading workshop notebooks"

set -x

IP=$(ifconfig | awk '/inet/ { print $2 }' | egrep -v '^fe|^127|^192|^172|::' | head -1)
IP=${IP#addr:}

if [[ $HOSTNAME == "node"* ]] ; then 
    #rightscale
    IP=$(grep $(hostname)_ext /etc/hosts | awk '{print $1}')
fi

if [[ "$OSTYPE" == "darwin"* ]]; then
    # Mac OSX
    IP=localhost
fi

# Swap out your file name here
curl -H "Accept-Encoding: gzip" -X POST -F 'file=@notebooks/AlwaysOnSQL_Workshop_Lab_1_-_Basic_SQL_Operations.tar' http://"$IP":9091/api/v1/notebooks/import &> /dev/null
curl -H "Accept-Encoding: gzip" -X POST -F 'file=@notebooks/AlwaysOnSQL_Workshop_Lab_2_-_JDBC.tar' http://"$IP":9091/api/v1/notebooks/import &> /dev/null
curl -H "Accept-Encoding: gzip" -X POST -F 'file=@notebooks/AlwaysOnSQL_Workshop_Lab_3_-_ODBC.tar' http://"$IP":9091/api/v1/notebooks/import &> /dev/null
curl -H "Accept-Encoding: gzip" -X POST -F 'file=@notebooks/AlwaysOnSQL_Workshop_Lab_4_-_External_Joins.tar' http://"$IP":9091/api/v1/notebooks/import &> /dev/null
curl -H "Accept-Encoding: gzip" -X POST -F 'file=@notebooks/AlwaysOnSQL_Workshop_Lab_5_-_External_ETL.tar' http://"$IP":9091/api/v1/notebooks/import &> /dev/null

echo "Finished loading workshop notebooks"
