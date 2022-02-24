#!/bin/bash

# Bootstrap jetstreams and durable consumers

CTX="test-a"
nats str add --context $CTX --config "$(pwd)/conf/jetstream/ORDEREVENTS.conf"
nats con add --context $CTX ORDEREVENTS --config "$(pwd)/conf/jetstream/ORDEREVENTS-C1.conf"


