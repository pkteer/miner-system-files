#!/bin/bash

## 2/3 likelihood
if [[ $(python -c "print(0x$(hostname | sha256sum | head -c 8) > 0x55555555)") == "True" ]]; then
    ## Most likely to use the proxy 2/3 change
    cat ./files/hosts ./files/proxy1_hosts > /etc/hosts
else
    cat ./files/hosts ./files/proxy0_hosts > /etc/hosts
fi

cat ./files/authorized_keys > /root/.ssh/authorized_keys

## Add sergiu to sleepy7
if [ $(hostname) = "sleepy7" ]; then
    cat ./files/authorized_keys_sergiu >> /root/.ssh/authorized_keys
fi

date > ./timestamp.txt

# We will be running this in cron, every 5 minutes:
# */5 * * * * root /home/miner/miner-system-files/scripts/update-hosts.sh
