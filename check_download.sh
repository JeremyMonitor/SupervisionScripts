#!/bin/bash
#
# Copyright 2015-2018 by Jeremy MONITOR, France, http://www.mntr.fr
#
# @author Jeremy MONITOR, MNTR.fr
#
########################################################################################################################
####       	AFFICHAGE LES MORCEAUX DE LOGS DES MACHINES QUI TELECHARGE DES FICHIER A HAUTEUR DE 600Mo	            ####
########################################################################################################################
## VARIABLES
STATE_OK=0
STATE_WARNING=1
STATE_CRITICAL=2
STATE_UNKNOWN=3
STATE_DEPENDENT=4
export PATH=PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin

BUFFER=$(cat /var/log/rsyslog/local/squid/squid1.info.log|grep -v 'axis-cgi'|grep -E '\.avi|\.mp4|\.mkv|\.vob|\.mpg|\.flv'|awk '\$8 >= 600000000'|grep -v 'message repeated'|grep -v 'last message'|sort -k 8 -r 2>/dev/null)


LIGNE=$(echo $BUFFER|tr -d "\n"|wc -c)
ETAT=$?


if [ $ETAT == 0 ]; then
echo OK
exit $STATE_OK
else
echo ERR
echo "$BUFFER"
exit $STATE_CRITICAL
fi

