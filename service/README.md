# Share an API-style service (request/reply)

```bash
# with access to test-a account privatekey
./acct-export.sh -a

# with access to test-b account privatekey
./acct-import.sh -a

# as test-a
nats reply --context "test-a" --queue "payment-responder" "retail.v1.payment.tender" "Payment tendered!"
08:48:36 Listening on "retail.v1.payment.tender" in group "payment-responder"
08:49:23 [#0] Received on subject "retail.v1.payment.tender":
08:49:23 Nats-Request-Info: {"acc":"AD7T74QPICDLJYKEJQ37RKP2VXUJYUUIHZ7XMGMWFEOZNKVO3VBF46F7","rtt":88255126}

Tender my payment please!
08:49:23 cnt: 0

# as test-b
nats request --context "test-b" "retail.v1.payment.tender" "Tender my payment please!"
08:49:23 Sending request on "retail.v1.payment.tender"
08:49:23 Received on "_INBOX.qH22EvqBXH70dpuV4E6oWJ.iGVnfLLO" rtt 48.544434ms
Payment tendered!
```


