#!/bin/bash
#
# Copyright 2015-2018 by Jeremy MONITOR, France, http://www.mntr.fr
#
# @author Jeremy MONITOR, MNTR.fr
#
########################################################################################################################
####       	UTILISATION DE SPEEDTEST.py ET GENERE UN CODE UTILISE POUR AFFICHAGE ET GRAPH DANS NAGIOS	            ####
########################################################################################################################
## VARIABLES
STATE_OK=0
STATE_WARNING=1
STATE_CRITICAL=2
STATE_UNKNOWN=3
STATE_DEPENDENT=4
export PATH=PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin

export ETAT=1
export FICHIER=$(mktemp)
export FICHIER2=$(mktemp)

export PING_WARNING=$4
export PING_CRITICAL=$5
export DOWN_WARNING=$6
export DOWN_CRITICAL=$7
export UP_WARNING=$8
export UP_CRITICAL=$9


if [ "$PING_WARNING" == "" ];
then
export PING_WARNING=50
fi
if [ "$PING_CRITICAL" == "" ];
then
export $PING_CRITICAL=50
fi
if [ "$DOWN_WARNING" == "" ];
then
export DOWN_WARNING=100
fi
if [ "$DOWN_CRITICAL" == "" ];
then
export $DOWN_CRITICAL=100
fi
if [ "$UP_WARNING" == "" ];
then
export UP_WARNING=100
fi
if [ "$UP_CRITICAL" == "" ];
then
export UP_CRITICAL=100
fi



BUFFER=$($SSHPASS -p $1 ssh -o UserKnownHostsFile=/dev/null -o CheckHostIP=no -o HashKnownHosts=no -o ConnectTimeout=30 -o StrictHostKeyChecking=no $2@$3 "/usr/bin/python speedtest-cli  --simple" 2>/dev/null)


PING=$(echo "$BUFFER"|grep Ping|awk '{print $2}')
DOWN=$(echo "$BUFFER"|grep Download|awk '{print $2}')
UP=$(echo "$BUFFER"|grep Upload|awk '{print $2}')

PINGVAR=$(echo "$BUFFER"|grep Ping|awk '{print $3}')
DOWNVAR=$(echo "$BUFFER"|grep Download|awk '{print $3}')
UPVAR=$(echo "$BUFFER"|grep Upload|awk '{print $3}')


LIGNE=$(echo $BUFFER|tr -d "\n"|wc -c)

if [ $LIGNE -eq 0 ]; then
echo "OK|'PING'=$PING$PINGVAR;$PING_WARNING;$PING_CRITICAL;0;$PING 'DOWNLOAD'=$DOWN$DOWNVAR;$DOWN_WARNING;$DOWN_CRITICAL;0;$DOWN 'UPLOAD'=$UP$UPVAR;$UP_WARNING;$UP_CRITICAL;0;$UP"
exit $STATE_OK
else
echo "ERR"
exit $STATE_CRITICAL
fi









