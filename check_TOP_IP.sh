#!/bin/bash
#
# Copyright 2015-2018 by Jeremy MONITOR, France, http://www.mntr.fr
#
# @author Jeremy MONITOR, MNTR.fr
#
################################################################################
####       	AFFICHAGE LES IP QUI GENERE LE PLUS DE TRAFFIC	            ####
################################################################################
## VARIABLES
STATE_OK=0
STATE_WARNING=1
STATE_CRITICAL=2
STATE_UNKNOWN=3
STATE_DEPENDENT=4

export PATH=PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin
## EXECUTION DE LA COMMANDE PENDANT 60 SECONDES
BUFFER=$(iptraf-ng -i all -t 1 -B -L /tmp/traffic.log;sleep 60;cat /tmp/traffic.log)
## TRAITEMENT
echo $BUFFER
LIGNE=$(echo $BUFFER|tr -d "\n"|wc -c)

if [ $LIGNE -eq 0 ]; then
echo OK
exit $STATE_OK
else
#echo ERR
echo "$BUFFER"
exit $STATE_CRITICAL
fi