#!/bin/bash
#
# Copyright 2015-2018 by Jeremy MONITOR, France, http://www.mntr.fr
#
# @author Jeremy MONITOR, MNTR.fr
#
################################################################################################################
####       	TEST DE NOMBRE D'INTERFACE RESEAU												                ####
################################################################################################################
## VARIABLES
STATE_OK=0
STATE_WARNING=1
STATE_CRITICAL=2
STATE_UNKNOWN=3
STATE_DEPENDENT=4
export PATH=PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin

BUFFER=$(ifconfig|grep Link|grep -v "lo"|awk '{print $1}'|wc -l 2>/dev/null)

LOG=$(echo "$BUFFER"|wc -l)
NB=$(grep -c . <<< $LOG)

LIGNE=$(echo $BUFFER|tr -d "\n"|wc -c)

if [ $LIGNE -eq 0 ]; then
echo "$BUFFER"
exit $STATE_OK
else
echo "Connexion Impossible"
exit $STATE_CRITICAL
fi
