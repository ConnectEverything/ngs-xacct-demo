#!/bin/bash

# Account Refs
ACCTA="todd-test-a"
ACCTAPUBKEY="AD5FKXQPZYFD6MI4WF23SMWAFWTAFFU44XDIH2N222XY5HUBL35WGH3L"

ACCTB="todd-test-b"
ACCTBPUBKEY="AD7T74QPICDLJYKEJQ37RKP2VXUJYUUIHZ7XMGMWFEOZNKVO3VBF46F7"

ACCTC="todd-test-c"
ACCTCPUBKEY="ABTJUJC5DHOPQHI2WLUDUBTYDDNJKP45J7SWUDPP673TK3X7U5FUGU33"

#### Imports ####

addimports () {
# ACCTB
nsc add import --token "ORDEREVENTS-GRANT-DELIVER-ACCTB.tok" --account $ACCTB --name "ORDEREVENTS-GRANT-DELIVER" --local-subject "retail.v1.order.events"
nsc add import --token "ORDEREVENTS-GRANT-ACK-ACCTB.tok" --account $ACCTB --name "ORDEREVENTS-GRANT-ACK" --local-subject "\$JS.ACK.ORDEREVENTS.ORDEREVENTS-C1.>" --service
nsc add import --token "ORDEREVENTS-GRANT-INFO-ACCTB.tok" --account $ACCTB --name "ORDEREVENTS-GRANT-INFO" --local-subject "ACCTA.API.CONSUMER.INFO.ORDEREVENTS.ORDEREVENTS-C1" --service
}

deleteimports () {
nsc delete import --account $ACCTB --src-account $ACCTAPUBKEY --subject "deliver.retail.v1.order.events"
nsc delete import --account $ACCTB --src-account $ACCTAPUBKEY --subject "\$JS.ACK.ORDEREVENTS.ORDEREVENTS-C1.>"
nsc delete import --account $ACCTB --src-account $ACCTAPUBKEY --subject "\$JS.API.CONSUMER.INFO.ORDEREVENTS.ORDEREVENTS-C1"
}

while getopts "a d" option
do
    case ${option} in
        d) deleteimports ;;
        a) addimports ;;
    esac
done