#!/bin/bash

# Account Refs
ACCTA="todd-test-a"
ACCTAPUBKEY="AD5FKXQPZYFD6MI4WF23SMWAFWTAFFU44XDIH2N222XY5HUBL35WGH3L"

ACCTB="todd-test-b"
ACCTBPUBKEY="AD7T74QPICDLJYKEJQ37RKP2VXUJYUUIHZ7XMGMWFEOZNKVO3VBF46F7"

ACCTC="todd-test-c"
ACCTCPUBKEY="ABTJUJC5DHOPQHI2WLUDUBTYDDNJKP45J7SWUDPP673TK3X7U5FUGU33"

#### Exports ####

addexports () {
# ACCTA
nsc add export --private --account $ACCTA --name "ORDEREVENTS-GRANT-DELIVER" --subject "deliver.retail.v1.order.events"
nsc add export --private --account $ACCTA --name "ORDEREVENTS-GRANT-ACK" --subject "\$JS.ACK.ORDEREVENTS.ORDEREVENTS-C1.>" --service
nsc add export --private --account $ACCTA --name "ORDEREVENTS-GRANT-INFO" --subject "\$JS.API.CONSUMER.INFO.ORDEREVENTS.ORDEREVENTS-C1" --service

# Generate an activation token for ACCTB import
nsc generate activation --output-file "ORDEREVENTS-GRANT-DELIVER-ACCTB.tok" --account $ACCTA --subject "deliver.retail.v1.order.events" --target-account $ACCTBPUBKEY
nsc generate activation --output-file "ORDEREVENTS-GRANT-ACK-ACCTB.tok" --account $ACCTA --subject "\$JS.ACK.ORDEREVENTS.ORDEREVENTS-C1.>" --target-account $ACCTBPUBKEY
nsc generate activation --output-file "ORDEREVENTS-GRANT-INFO-ACCTB.tok" --account $ACCTA --subject "\$JS.API.CONSUMER.INFO.ORDEREVENTS.ORDEREVENTS-C1" --target-account $ACCTBPUBKEY
}

deleteexports () {
nsc delete export --account $ACCTA --subject "deliver.retail.v1.order.events"
nsc delete export --account $ACCTA --subject "\$JS.ACK.ORDEREVENTS.ORDEREVENTS-C1.>"
nsc delete export --account $ACCTA --subject "\$JS.API.CONSUMER.INFO.ORDEREVENTS.ORDEREVENTS-C1"
}

while getopts "a d" option
do
    case ${option} in
        d) deleteexports ;;
        a) addexports ;;
    esac
done