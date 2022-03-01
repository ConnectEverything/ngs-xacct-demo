# Share a JetStream Consumer message feed as a service

```bash
# as test-a and test-c contexts
./js-bootstrap.sh

# with access to test-a and test-c account privatekey
./acct-export.sh -a

# with access to test-b account privatekey
./acct-import.sh -a

# as test-a
nats request --context "test-a" "retail.v1.fulfill.completed" "Fulfill for order 1234 completed!"
15:19:05 Sending request on "retail.v1.fulfill.completed"
15:19:05 Received on "_INBOX.OqIbDYsMA41utbe3fqNYBa.To7xhXM7" rtt 26.516834ms
{"stream":"FULFILLEVENTS", "domain":"ngstest", "seq":9}

# as test-b
nats consumer next --context "test-b" --js-api-prefix "ACCTA.API" --ack --count 1 "FULFILLEVENTS" "FULFILLEVENTS-C1"
[15:23:38] subj: retail.v1.fulfill.completed / tries: 1 / cons seq: 9 / str seq: 9 / pending: 0

Fulfill for order 1234 completed!

Acknowledged message

# as test-c
nats request --context "test-c" "retail.v1.restock.requested" "Restock for item 5678 pronto!"
15:24:42 Sending request on "retail.v1.restock.requested"
15:24:42 Received on "_INBOX.AFIRFuyu54agRhhiaXNEMG.OK9qWFoT" rtt 21.060591ms
{"stream":"RESTOCKEVENTS", "domain":"ngstest", "seq":9}

# as test-b
nats consumer next --context "test-b" --js-api-prefix "ACCTC.API" --ack --count 1 "RESTOCKEVENTS" "RESTOCKEVENTS-C1"
[15:26:43] subj: retail.v1.restock.requested / tries: 1 / cons seq: 9 / str seq: 9 / pending: 0

Restock for item 5678 pronto!

Acknowledged message
```

## Revoke access
 
```bash
# ACCTC revokes ACCTB's access to RESTOCKEVENTS by adding a revocation activation 
nsc revocations add-activation --account "todd-test-c" --service --subject "\$JS.API.CONSUMER.MSG.NEXT.RESTOCKEVENTS.RESTOCKEVENTS-C1" --target-account "AD7T74QPICDLJYKEJQ37RKP2VXUJYUUIHZ7XMGMWFEOZNKVO3VBF46F7"

nsc revocations list-activations --account "todd-test-c" --service --subject "\$JS.API.CONSUMER.MSG.NEXT.RESTOCKEVENTS.RESTOCKEVENTS-C1"
+------------------------------------------------------------------------------------------+
|                  Revoked Accounts for service RESTOCKEVENTS-GRANT-NEXT                   |
+----------------------------------------------------------+-------------------------------+
| Public Key                                               | Revoke Credentials Before     |
+----------------------------------------------------------+-------------------------------+
| AD7T74QPICDLJYKEJQ37RKP2VXUJYUUIHZ7XMGMWFEOZNKVO3VBF46F7 | Fri, 25 Feb 2022 19:20:20 PST |
+----------------------------------------------------------+-------------------------------+

# ACCTC restores ACCTB's access to RESTOCKEVENTS by deleting the revocation activation
nsc revocations delete-activation --account "todd-test-c" --service --subject "\$JS.API.CONSUMER.MSG.NEXT.RESTOCKEVENTS.RESTOCKEVENTS-C1" --target-account "AD7T74QPICDLJYKEJQ37RKP2VXUJYUUIHZ7XMGMWFEOZNKVO3VBF46F7"
```