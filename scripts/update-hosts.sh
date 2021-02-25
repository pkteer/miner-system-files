#!/bin/bash
cd /home/miner/miner-system-files/

## Any changes to this script and we re-invoke
/usr/bin/git pull | grep -q 'up to date' || exec bash ./scripts/update-hosts.sh

## 50/50 coin toss
if [[ $(python -c "print(0x$(hostname | sha256sum | head -c 8) > 0x7fffffff)") == "True" ]]; then
    cat ./etc/hosts ./etc/proxy0_hosts > /etc/hosts
else
    cat ./etc/hosts ./etc/proxy1_hosts > /etc/hosts
fi

# We will be running this in cron:
# 15 * * * * root run-parts /home/miner/miner-system-files/scripts/update-hosts.sh
