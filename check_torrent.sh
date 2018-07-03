#!/bin/bash
#
# Copyright 2015-2018 by Jeremy MONITOR, France, http://www.mntr.fr
#
# @author Jeremy MONITOR, MNTR.fr
#
################################################################################
####       	AFFICHAGE DES IP QUI TELECHARGE SOUS TORRENT       	            ####
################################################################################
## VARIABLES
STATE_OK=0
STATE_WARNING=1
STATE_CRITICAL=2
STATE_UNKNOWN=3
STATE_DEPENDENT=4
export PROCESS=0
export PATH=PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin

BUFFER=$(cat /var/log/rsyslog/local/squid/squid1.info.log|grep 'announce?' 2>/dev/null)
LIGNE=$(echo $BUFFER|tr -d "\n"|wc -c)

if [ $LIGNE -eq 0 ]; then
echo OK
exit $STATE_OK
else
#echo ERR
echo "$BUFFER"|grep -Eo '([0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}).* GET(.*) -'
exit $STATE_CRITICAL
fi

