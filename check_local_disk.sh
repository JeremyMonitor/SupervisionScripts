#!/bin/bash
#
# Copyright 2015-2018 by Jeremy MONITOR, France, http://www.mntr.fr
#
# @author Jeremy MONITOR, MNTR.fr
#
################################################################################################################
####       	TEST LES BADS BLOCKS DES DISQUES												                ####
################################################################################################################
## VARIABLES
STATE_OK=0
STATE_WARNING=1
STATE_CRITICAL=2
STATE_UNKNOWN=3
STATE_DEPENDENT=4
export PATH=PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin

BUFFER=$(fsck -nfv 2>/dev/null|grep bloc|grep -E 'bad blocks|défectueux'|awk '{print $1}' 2>/dev/null)
LIGNE=$(echo $BUFFER|tr -d "\n"|wc -c)

if [ $LIGNE -eq 0 ]; then
echo "ERR"
exit $STATE_CRITICAL
else
echo "OK"
echo "$BUFFER"
exit $STATE_OK
fi