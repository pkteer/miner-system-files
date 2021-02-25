#!/bin/bash
cd /home/miner/miner-system-files/

## Any changes to this script and we re-invoke
/usr/bin/git pull | grep -q 'up to date' || exec bash ./scripts/update-hosts.sh

## 50/50 coin toss
if [[ $(python -c "print(0x$(hostname | sha256sum | head -c 8) > 0x55555555)") == "True" ]]; then
    ## Most likely to use the proxy 2/3 change
    cat ./etc/hosts ./etc/proxy1_hosts > /etc/hosts
else
    cat ./etc/hosts ./etc/proxy0_hosts > /etc/hosts
fi

date > ./timestamp.txt

# We will be running this in cron, every 5 minutes:
# */5 * * * * root /home/miner/miner-system-files/scripts/update-hosts.sh
