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
# nsc add export --account $ACCTA --subject "\$JS.API.STREAM.INFO.ORDEREVENTS" --service
nsc add export --account $ACCTA --subject "\$JS.API.CONSUMER.INFO.ORDEREVENTS.ORDEREVENTS-C1" --service
nsc add export --account $ACCTA --subject "\$JS.ACK.ORDEREVENTS.ORDEREVENTS-C1.>" --service
nsc add export --account $ACCTA --subject "deliver.retail.v1.order.events"
}

deleteexports () {
# nsc delete export --account $ACCTA --subject "\$JS.API.STREAM.INFO.ORDEREVENTS"
nsc delete export --account $ACCTA --subject "\$JS.API.CONSUMER.INFO.ORDEREVENTS.ORDEREVENTS-C1"
nsc delete export --account $ACCTA --subject "\$JS.ACK.ORDEREVENTS.ORDEREVENTS-C1.>"
nsc delete export --account $ACCTA --subject "deliver.retail.v1.order.events"
}

while getopts "a d" option
do
    case ${option} in
        d) deleteexports ;;
        a) addexports ;;
    esac
done