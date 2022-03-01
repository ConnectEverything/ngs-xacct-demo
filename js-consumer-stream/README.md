# Share a JetStream Consumer message feed as a stream

```bash
# as test-a context
./js-bootstrap.sh

# with access to test-a account privatekey
./acct-export.sh -a

# with access to test-b account privatekey
./acct-import.sh -a

# as test-a
nats request --context "test-a" "retail.v1.order.captured" "Captured order 1234!"
14:36:10 Sending request on "retail.v1.order.captured"
14:36:10 Received on "_INBOX.8T7G6V9J6DksHdJYOYgsXJ.zPnc8UTP" rtt 18.417124ms
{"stream":"ORDEREVENTS", "domain":"ngstest", "seq":3}

# as test-b, note: --js-api-prefix not technically required here but best practice for cross-account JetStream
nats sub --context "test-b" --js-api-prefix "ACCTA.API" --ack --queue "order-processor" "retail.v1.order.events"
14:36:06 Subscribing on retail.v1.order.events with acknowledgement of JetStream messages
[#1] Received JetStream message: consumer: ORDEREVENTS > ORDEREVENTS-C1 / subject: retail.v1.order.events / delivered: 1 / consumer seq: 3 / stream seq: 3 / ack: true
Captured order 1234!

# test-b can also get JS Consumer info, --js-api-prefix is required here
nats consumer info --context "test-b" --js-api-prefix "ACCTA.API" "ORDEREVENTS" "ORDEREVENTS-C1"
Information for Consumer ORDEREVENTS > ORDEREVENTS-C1 created 2022-03-01T14:27:56-08:00

Configuration:

        Durable Name: ORDEREVENTS-C1
    Delivery Subject: deliver.retail.v1.order.events
      Deliver Policy: All
 Deliver Queue Group: order-processor
          Ack Policy: Explicit
            Ack Wait: 30s
       Replay Policy: Instant
     Max Ack Pending: 100
        Flow Control: false

Cluster Information:

                Name: ngstest-az-uswest2
              Leader: az-uswest2-natsjs-4

State:

   Last Delivered Message: Consumer sequence: 3 Stream sequence: 3 Last delivery: 2m5s ago
     Acknowledgment floor: Consumer sequence: 3 Stream sequence: 3 Last Ack: 2m5s ago
         Outstanding Acks: 0 out of maximum 100
     Redelivered Messages: 0
     Unprocessed Messages: 0
          Active Interest: Active using Queue Group order-processor
```