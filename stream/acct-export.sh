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
# ACCTA private export CARTEVENTS
nsc add export --private --name "CARTEVENTS-GRANT-STREAM" --account $ACCTA --subject "retail.v1.cart.>"

# Generate a CARTEVENTS-GRANT-STREAM activiation token for ACCTB import
nsc generate activation --output-file "CARTEVENTS-GRANT-STREAM-ACCTB.tok" --account $ACCTA --subject "retail.v1.cart.>" --target-account $ACCTBPUBKEY
}

deleteexports () {
nsc delete export --account $ACCTA --subject "retail.v1.cart.>"
}

while getopts "a d" option
do
    case ${option} in
        d) deleteexports ;;
        a) addexports ;;
    esac
done