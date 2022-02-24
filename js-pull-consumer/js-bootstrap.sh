#!/bin/bash

# Bootstrap jetstreams and durable consumers

CTX="test-a"
nats str add --context $CTX --config "$(pwd)/conf/jetstream/FULFILLEVENTS.conf"
nats con add --context $CTX FULFILLEVENTS --config "$(pwd)/conf/jetstream/FULFILLEVENTS-C1.conf"


