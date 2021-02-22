#!/usr/bash
cd /home/miner/miner-system-files/
/usr/bin/git pull
yes | cp etc/hosts /etc/hosts

# We will be running this in cron:
# 15 * * * * root run-parts /home/miner/miner-system-files/scripts/update-hosts.sh
