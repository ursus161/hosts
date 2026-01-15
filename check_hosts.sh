#!/bin/bash
cat /etc/hosts | while read line
do
    ip=$(echo $line | awk '{print $1}')
    nume=$(echo $line | awk '{print $2}')
    
    if [[ -z "$line" ]] || [[ "$line" == "#"* ]]; then
        continue
    fi 
    #linii goale sau comentarii, se trece peste (evident tot ce incepe cu # e comentariu)
    adresa=$(nslookup $nume 8.8.8.8 2>/dev/null | grep "Address:" | tail -1 | awk '{print $2}')
    #modificarea este pasarea unui server DNS ca argument, puteam sa pun si 1.1.1.1 pentru un req la DNS-ul Cloudflare
    #by default, cum gresisem initial mi se ducea in /etc/hosts si imi gasea gresit din cauza modificarii mele
    #doar daca nu gasea se duce sa faca request la se ducea la DNS-ul implicit (/etc/resolv.conf), insa acum se duce mai intai la 8.8.8.8 si ignora /etc/hosts 
    if [[ -n "$adresa" ]] && [[ "$ip" != "$adresa" ]]; then
        echo "Bogus IP for $nume in /etc/hosts!"
    fi
done
