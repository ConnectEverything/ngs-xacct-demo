# Share a message feed (non-JetStream) as a stream

```bash
# with access to test-a account privatekey
./acct-export.sh -a

# with access to test-b account privatekey
./acct-import.sh -a

# as test-b
nats sub --context "test-b" --queue "cart-processor" "retail.v1.cart.>"

# as test-a
nats pub --context "test-a" "retail.v1.cart.started" "Customer initiated Cart 1234!"
```
