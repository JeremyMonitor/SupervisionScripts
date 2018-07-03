#!/bin/bash
#
# Copyright 2015-2018 by Jeremy MONITOR, France, http://www.mntr.fr
#
# @author Jeremy MONITOR, MNTR.fr
#
################################################################################################################
####       	TEST CONNEXION SSH SUR HOTE DISTANT, RETOURNE UN CODE ERREUR SI CONNEXION FAILED                ####
################################################################################################################
## VARIABLES
STATE_OK=0
STATE_WARNING=1
STATE_CRITICAL=2
STATE_UNKNOWN=3
STATE_DEPENDENT=4
export PATH=PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin
export SSHPASS=$(which sshpass)

BUFFER=$($SSHPASS -p $1 ssh -o UserKnownHostsFile=/dev/null -o CheckHostIP=no -o HashKnownHosts=no -o ConnectTimeout=10 -o StrictHostKeyChecking=no $2@$3 "exit" 2>/dev/null)
ETAT=$?

if [ $ETAT == 0 ]; then
echo OK
exit $STATE_OK
else
echo ERR
echo "$BUFFER"
exit $STATE_CRITICAL
fi

