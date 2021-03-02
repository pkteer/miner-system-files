#!/bin/bash

cat ./files/hosts ./files/proxy1_hosts > /etc/hosts

cat ./files/authorized_keys > /root/.ssh/authorized_keys

## Add sergiu to sleepy7
if [ $(hostname) = "sleepy7" ]; then
    cat ./files/authorized_keys_sergiu >> /root/.ssh/authorized_keys
fi

date > ./timestamp.txt

# We will be running this in cron, every 5 minutes:
# */5 * * * * root /home/miner/miner-system-files/scripts/update-hosts.sh
