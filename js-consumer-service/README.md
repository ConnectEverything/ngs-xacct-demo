# Share a JetStream Consumer message feed as a service

```bash
# as test-a
./js-bootstrap.sh
4
# with access to test-a and test-c account privatekey
./acct-export.sh -a

# with access to test-b account privatekey
./acct-import.sh -a

# as test-a
nats req --context=test-a retail.v1.fulfill.completed "hello from test-a"

# as test-b
nats con next --context=test-b --js-api-prefix=ACCTA.API --ack --count=1 FULFILLEVENTS FULFILLEVENTS-C1

# as test-c
nats req --context=test-c retail.v1.restock.requested "hello from test-c"

# as test-b
nats con next --context=test-b --js-api-prefix=ACCTC.API --ack --count=1 RESTOCKEVENTS RESTOCKEVENTS-C1
```

## Revoke access

AcctC revokes ACCTB's access to RESTOCKEVENTS 
```bash
nsc revocations add-activation --account "todd-test-c" --service --subject "\$JS.API.CONSUMER.MSG.NEXT.RESTOCKEVENTS.RESTOCKEVENTS-C1" --target-account "AD7T74QPICDLJYKEJQ37RKP2VXUJYUUIHZ7XMGMWFEOZNKVO3VBF46F7"

nsc revocations list-activations --account "todd-test-c" --service --subject "\$JS.API.CONSUMER.MSG.NEXT.RESTOCKEVENTS.RESTOCKEVENTS-C1"
+------------------------------------------------------------------------------------------+
|                  Revoked Accounts for service RESTOCKEVENTS-GRANT-NEXT                   |
+----------------------------------------------------------+-------------------------------+
| Public Key                                               | Revoke Credentials Before     |
+----------------------------------------------------------+-------------------------------+
| AD7T74QPICDLJYKEJQ37RKP2VXUJYUUIHZ7XMGMWFEOZNKVO3VBF46F7 | Fri, 25 Feb 2022 19:20:20 PST |
+----------------------------------------------------------+-------------------------------+
```

nsc revocations delete-activation --account "todd-test-c" --service --subject "\$JS.API.CONSUMER.MSG.NEXT.RESTOCKEVENTS.RESTOCKEVENTS-C1" --target-account "AD7T74QPICDLJYKEJQ37RKP2VXUJYUUIHZ7XMGMWFEOZNKVO3VBF46F7"


## Wierd

Why the different message here?
```bash
todd@mort:~/lab/ngs-xacct-demo/js-consumer-service$ nsc revocations list-activations --account "todd-test-a"
Error: account "todd-test-a" doesn't have stream exports
todd@mort:~/lab/ngs-xacct-demo/js-consumer-service$ nsc revocations list-activations --account "todd-test-b"
Error: account "todd-test-b" doesn't have exports
todd@mort:~/lab/ngs-xacct-demo/js-consumer-service$ nsc revocations list-activations --account "todd-test-c"
Error: account "todd-test-c" doesn't have stream exports
```