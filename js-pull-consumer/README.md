# public-export-js-pull-consumer

```bash
# as test-a
./js-bootstrap.sh

# with access to test-a account privatekey
./public-acct-export.sh -a

# with access to test-b account privatekey
./public-acct-import.sh -a

# as test-a
nats req --context=test-a retail.v1.fulfill.completed "hello from test-a"

# as test-b
nats con next --context=test-b --js-api-prefix=ACCTA.API --ack --count=1 FULFILLEVENTS FULFILLEVENTS-C1
```