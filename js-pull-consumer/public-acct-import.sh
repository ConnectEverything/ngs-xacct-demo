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
nsc add import --account $ACCTB --name "ACCTA.API.CONSUMER.MSG.NEXT.FULFILLEVENTS.FULFILLEVENTS-C1" --src-account $ACCTAPUBKEY --remote-subject "\$JS.API.CONSUMER.MSG.NEXT.FULFILLEVENTS.FULFILLEVENTS-C1" --local-subject "ACCTA.API.CONSUMER.MSG.NEXT.FULFILLEVENTS.FULFILLEVENTS-C1" --service
# nsc add import --account $ACCTB --name "ACCTA.API.STREAM.INFO.FULFILLEVENTS" --remote-subject "\$JS.API.STREAM.INFO.FULFILLEVENTS" --src-account $ACCTAPUBKEY --local-subject "ACCTA.API.STREAM.INFO.FULFILLEVENTS" --service
nsc add import --account $ACCTB --name "ACCTA.API.CONSUMER.INFO.FULFILLEVENTS.FULFILLEVENTS-C1" --remote-subject "\$JS.API.CONSUMER.INFO.FULFILLEVENTS.FULFILLEVENTS-C1" --src-account $ACCTAPUBKEY --local-subject "ACCTA.API.CONSUMER.INFO.FULFILLEVENTS.FULFILLEVENTS-C1" --service
nsc add import --account $ACCTB --name "ACCTA.ACK.FULFILLEVENTS.FULFILLEVENTS-C1" --remote-subject "\$JS.ACK.FULFILLEVENTS.FULFILLEVENTS-C1.>" --src-account $ACCTAPUBKEY --local-subject "\$JS.ACK.FULFILLEVENTS.FULFILLEVENTS-C1.>" --service
}

deleteimports () {
nsc delete import --account $ACCTB --src-account $ACCTAPUBKEY --subject "\$JS.API.CONSUMER.MSG.NEXT.FULFILLEVENTS.FULFILLEVENTS-C1"
# nsc delete import --account $ACCTB --src-account $ACCTAPUBKEY --subject "\$JS.API.STREAM.INFO.FULFILLEVENTS"
nsc delete import --account $ACCTB --src-account $ACCTAPUBKEY --subject "\$JS.API.CONSUMER.INFO.FULFILLEVENTS.FULFILLEVENTS-C1"
nsc delete import --account $ACCTB --src-account $ACCTAPUBKEY --subject "\$JS.ACK.FULFILLEVENTS.FULFILLEVENTS-C1.>"
}

while getopts "a d" option
do
    case ${option} in
        d) deleteimports ;;
        a) addimports ;;
    esac
done