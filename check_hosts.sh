#!/bin/bash
cat /etc/hosts | while read line
do
    ip=$(echo $line | awk '{print $1}')
    nume=$(echo $line | awk '{print $2}')
    adresa=$(nslookup $nume 2>/dev/null | grep "Address:" | tail -1 | awk '{print $2}')
    
    if [[ "$ip" != "$adresa" ]]; then
        echo "Bogus IP for $nume in /etc/hosts!"
    fi
done
