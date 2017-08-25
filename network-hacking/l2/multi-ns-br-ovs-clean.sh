#!/usr/bin/env bash

ip netns del green
ip netns del red

ip netns del red
ip netns del green
ip netns del r-dhcp
ip netns del g-dhcp

ip link set dev r-bridge down
brctl delbr r-bridge
ip link set dev g-bridge down
brctl delbr g-bridge

ip link del dev g-veth1
ip link del dev r-veth1
ovs-vsctl del-br ovs-br

ip link del dev g-veth0-bis
ip link del dev r-veth0-bis