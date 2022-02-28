# Share an API-style service (request/reply)

```bash
# with access to test-a account privatekey
./acct-export.sh -a

# with access to test-b account privatekey
./acct-import.sh -a

# as test-a
nats reply --context test-a retail.v1.payment.tender "hello reply from test-a"

# as test-b
nats req --context test-b retail.v1.payment.tender "hello from test-b"
```


