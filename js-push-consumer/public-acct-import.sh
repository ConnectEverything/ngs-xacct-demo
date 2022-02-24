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
nsc add import --account $ACCTB --name "retail.v1.order.captured" --src-account $ACCTAPUBKEY --remote-subject "deliver.retail.v1.order.captured" --local-subject "retail.v1.order.captured"
# nsc add import --account $ACCTB --name "ACCTA.API.STREAM.INFO.ORDEREVENTS" --remote-subject "\$JS.API.STREAM.INFO.ORDEREVENTS" --src-account $ACCTAPUBKEY --local-subject "ACCTA.API.STREAM.INFO.ORDEREVENTS" --service
nsc add import --account $ACCTB --name "ACCTA.API.CONSUMER.INFO.ORDEREVENTS.ORDEREVENTS-C1" --remote-subject "\$JS.API.CONSUMER.INFO.ORDEREVENTS.ORDEREVENTS-C1" --src-account $ACCTAPUBKEY --local-subject "ACCTA.API.CONSUMER.INFO.ORDEREVENTS.ORDEREVENTS-C1" --service
nsc add import --account $ACCTB --name "ACCTA.ACK.ORDEREVENTS.ORDEREVENTS-C1" --remote-subject "\$JS.ACK.ORDEREVENTS.ORDEREVENTS-C1.>" --src-account $ACCTAPUBKEY --local-subject "\$JS.ACK.ORDEREVENTS.ORDEREVENTS-C1.>" --service
}

deleteimports () {
nsc delete import --account $ACCTB --src-account $ACCTAPUBKEY --subject "deliver.retail.v1.order.captured"
# nsc delete import --account $ACCTB --src-account $ACCTAPUBKEY --subject "\$JS.API.STREAM.INFO.ORDEREVENTS"
nsc delete import --account $ACCTB --src-account $ACCTAPUBKEY --subject "\$JS.API.CONSUMER.INFO.ORDEREVENTS.ORDEREVENTS-C1"
nsc delete import --account $ACCTB --src-account $ACCTAPUBKEY --subject "\$JS.ACK.ORDEREVENTS.ORDEREVENTS-C1.>"
}

while getopts "a d" option
do
    case ${option} in
        d) deleteimports ;;
        a) addimports ;;
    esac
done