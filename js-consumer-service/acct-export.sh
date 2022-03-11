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
# ACCTA public export FULFILLEVENTS (any account may import)
nsc add export --account $ACCTA --name "FULFILLEVENTS-GRANT-NEXT" --subject "\$JS.API.CONSUMER.MSG.NEXT.FULFILLEVENTS.FULFILLEVENTS-C1" --service --response-type "Stream"
nsc add export --account $ACCTA --name "FULFILLEVENTS-GRANT-ACK" --subject "\$JS.ACK.FULFILLEVENTS.FULFILLEVENTS-C1.>" --service
nsc add export --account $ACCTA --name "FULFILLEVENTS-GRANT-INFO" --subject "\$JS.API.CONSUMER.INFO.FULFILLEVENTS.FULFILLEVENTS-C1" --service

# ACCTC private export RESTOCKEVENTS
nsc add export --private --account $ACCTC --name "RESTOCKEVENTS-GRANT-NEXT" --subject "\$JS.API.CONSUMER.MSG.NEXT.RESTOCKEVENTS.RESTOCKEVENTS-C1" --service --response-type "Stream"
nsc add export --private --account $ACCTC --name "RESTOCKEVENTS-GRANT-ACK" --subject "\$JS.ACK.RESTOCKEVENTS.RESTOCKEVENTS-C1.>" --service
nsc add export --private --account $ACCTC --name "RESTOCKEVENTS-GRANT-INFO" --subject "\$JS.API.CONSUMER.INFO.RESTOCKEVENTS.RESTOCKEVENTS-C1" --service

# ACCTC creates RESTOCKEVENTS activation tokens that ACCTB may use for import
nsc generate activation --output-file "RESTOCKEVENTS-GRANT-NEXT-ACCTB.tok" --account $ACCTC --subject "\$JS.API.CONSUMER.MSG.NEXT.RESTOCKEVENTS.RESTOCKEVENTS-C1" --target-account $ACCTBPUBKEY
nsc generate activation --output-file "RESTOCKEVENTS-GRANT-ACK-ACCTB.tok" --account $ACCTC --subject "\$JS.ACK.RESTOCKEVENTS.RESTOCKEVENTS-C1.>" --target-account $ACCTBPUBKEY
nsc generate activation --output-file "RESTOCKEVENTS-GRANT-INFO-ACCTB.tok" --account $ACCTC --subject "\$JS.API.CONSUMER.INFO.RESTOCKEVENTS.RESTOCKEVENTS-C1"  --target-account $ACCTBPUBKEY
}

deleteexports () {
# ACCTA public export
nsc delete export --account $ACCTA --subject "\$JS.API.CONSUMER.MSG.NEXT.FULFILLEVENTS.FULFILLEVENTS-C1"
nsc delete export --account $ACCTA --subject "\$JS.ACK.FULFILLEVENTS.FULFILLEVENTS-C1.>"
nsc delete export --account $ACCTA --subject "\$JS.API.CONSUMER.INFO.FULFILLEVENTS.FULFILLEVENTS-C1"

# ACCTC private export
nsc delete export --account $ACCTC --subject "\$JS.API.CONSUMER.MSG.NEXT.RESTOCKEVENTS.RESTOCKEVENTS-C1"
nsc delete export --account $ACCTC --subject "\$JS.ACK.RESTOCKEVENTS.RESTOCKEVENTS-C1.>"
nsc delete export --account $ACCTC --subject "\$JS.API.CONSUMER.INFO.RESTOCKEVENTS.RESTOCKEVENTS-C1"
}

while getopts "a d" option
do
    case ${option} in
        d) deleteexports ;;
        a) addexports ;;
    esac
done