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
# ACCTB importing a public export from ACCTA
nsc add import --account $ACCTB --name "FULFILLEVENTS-GRANT-NEXT" --src-account $ACCTAPUBKEY --remote-subject "\$JS.API.CONSUMER.MSG.NEXT.FULFILLEVENTS.FULFILLEVENTS-C1" --local-subject "ACCTA.API.CONSUMER.MSG.NEXT.FULFILLEVENTS.FULFILLEVENTS-C1" --service
nsc add import --account $ACCTB --name "FULFILLEVENTS-GRANT-ACK" --remote-subject "\$JS.ACK.FULFILLEVENTS.FULFILLEVENTS-C1.>" --src-account $ACCTAPUBKEY --local-subject "\$JS.ACK.FULFILLEVENTS.FULFILLEVENTS-C1.>" --service
nsc add import --account $ACCTB --name "FULFILLEVENTS-GRANT-INFO" --remote-subject "\$JS.API.CONSUMER.INFO.FULFILLEVENTS.FULFILLEVENTS-C1" --src-account $ACCTAPUBKEY --local-subject "ACCTA.API.CONSUMER.INFO.FULFILLEVENTS.FULFILLEVENTS-C1" --service

# ACCTB importing a private export from ACCTC
nsc add import --token "RESTOCKEVENTS-GRANT-NEXT-ACCTB.tok" --account $ACCTB --name "RESTOCKEVENTS-GRANT-NEXT" --local-subject "ACCTC.API.CONSUMER.MSG.NEXT.RESTOCKEVENTS.RESTOCKEVENTS-C1"
nsc add import --token "RESTOCKEVENTS-GRANT-ACK-ACCTB.tok" --account $ACCTB --name "RESTOCKEVENTS-GRANT-ACK" --local-subject "\$JS.ACK.RESTOCKEVENTS.RESTOCKEVENTS-C1.>"
nsc add import --token "RESTOCKEVENTS-GRANT-INFO-ACCTB.tok" --account $ACCTB --name "RESTOCKEVENTS-GRANT-INFO" --local-subject "ACCTC.API.CONSUMER.INFO.RESTOCKEVENTS.RESTOCKEVENTS-C1"
}

deleteimports () {
# ACCTB imports from ACCTA
nsc delete import --account $ACCTB --src-account $ACCTAPUBKEY --subject "\$JS.API.CONSUMER.MSG.NEXT.FULFILLEVENTS.FULFILLEVENTS-C1"
nsc delete import --account $ACCTB --src-account $ACCTAPUBKEY --subject "\$JS.ACK.FULFILLEVENTS.FULFILLEVENTS-C1.>"
nsc delete import --account $ACCTB --src-account $ACCTAPUBKEY --subject "\$JS.API.CONSUMER.INFO.FULFILLEVENTS.FULFILLEVENTS-C1"

# ACCTB imports from ACCTC
nsc delete import --account $ACCTB --src-account $ACCTCPUBKEY --subject "\$JS.API.CONSUMER.MSG.NEXT.RESTOCKEVENTS.RESTOCKEVENTS-C1"
nsc delete import --account $ACCTB --src-account $ACCTCPUBKEY --subject "\$JS.ACK.RESTOCKEVENTS.RESTOCKEVENTS-C1.>"
nsc delete import --account $ACCTB --src-account $ACCTCPUBKEY --subject "\$JS.API.CONSUMER.INFO.RESTOCKEVENTS.RESTOCKEVENTS-C1"
}

while getopts "a d" option
do
    case ${option} in
        d) deleteimports ;;
        a) addimports ;;
    esac
done