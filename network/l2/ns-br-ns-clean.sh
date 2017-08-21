#!/usr/bin/env bash

ip netns del ns2
ip netns del ns3
ip link set dev br88 down
brctl delbr br88