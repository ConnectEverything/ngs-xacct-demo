#!/bin/bash

# Bootstrap jetstreams and durable consumers

# For public export/import demo
CTX="test-a"
nats str add --context $CTX --config "$(pwd)/conf/jetstream/FULFILLEVENTS.conf"
nats con add --context $CTX FULFILLEVENTS --config "$(pwd)/conf/jetstream/FULFILLEVENTS-C1.conf"

# For private export/import demo
CTX="test-c"
nats str add --context $CTX --config "$(pwd)/conf/jetstream/RESTOCKEVENTS.conf"
nats con add --context $CTX RESTOCKEVENTS --config "$(pwd)/conf/jetstream/RESTOCKEVENTS-C1.conf"

