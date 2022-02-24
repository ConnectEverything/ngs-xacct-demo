# public-export-js-push-consumer

```bash
# as test-a
./js-bootstrap.sh

# with access to test-a account privatekey
./public-public-acct-export.sh -a

# with access to test-b account privatekey
./public-public-acct-import.sh -a

# as test-a
nats req --context=test-a retail.v1.order.captured "hello from test-a"

# as test-b
nats sub --context=test-b --ack --queue=after-processor retail.v1.order.captured
```