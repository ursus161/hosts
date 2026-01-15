#!/bin/bash
while read -r ip rest; do
    [[ $ip =~ ^([0-9]{1,3}\.){3}[0-9]{1,3}$ ]] && echo "Valid: $ip" || echo "Invalid: $ip"
done < /etc/hosts
