#!/bin/bash
#
# Copyright 2015-2018 by Jeremy MONITOR, France, http://www.mntr.fr
#
# @author Jeremy MONITOR, MNTR.fr
#
#snmpwalk -v 2c -c public $1 $2
#COLOR=.1.3.6.1.2.1.43.11.1.1.6
#
################################################################################################################
####       	TEST DU TAUX DE DISPO DE TONNER EN SNMP	EN POURCENTAGE							                ####
################################################################################################################
## VARIABLES
STATE_OK=0
STATE_WARNING=1
STATE_CRITICAL=2
STATE_UNKNOWN=3
STATE_DEPENDENT=4
export PATH=PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin

ACTU=$(snmpwalk -v 2c -c public $1 .1.3.6.1.2.1.43.11.1.1.9.1.$2|cut -d= -f2|cut -d: -f2|cut -f2 -d " ")
TOTAL=$(snmpwalk -v 2c -c public $1 .1.3.6.1.2.1.43.11.1.1.8.1.$2|cut -d= -f2|cut -d: -f2|cut -f2 -d " ")

VALEUR=$(echo "100*$ACTU/$TOTAL"|bc)


echo $VALEUR"%"
