#!/usr/bin/env bash

# create 2 networking namespaces:
ip netns add green
ip netns add red

# create 4 *veth* pairs:
ip link add dev g-veth0 type veth peer name g-veth0-bis
ip link add dev r-veth0 type veth peer name r-veth0-bis
ip link add dev g-veth1 type veth peer name g-veth1-bis
ip link add dev r-veth1 type veth peer name r-veth1-bis

# create 2 Linux bridges:
brctl addbr g-bridge
brctl addbr r-bridge

# create 1 OVS bridge:
ovs-vsctl add-br ovs-br

# activate all devices:
ip link set dev g-bridge up
ip link set dev r-bridge up
ip link set dev g-veth0 up
ip link set dev g-veth0-bis up
ip link set dev r-veth0 up
ip link set dev r-veth0-bis up
ip link set dev g-veth1 up
ip link set dev g-veth1-bis up
ip link set dev r-veth1 up
ip link set dev r-veth1-bis up

# put devices to the 2 namespaces:
ip link set g-veth0 netns green
ip link set r-veth0 netns red

# activate devices in the namespaces:
ip netns exec green ip link set dev g-veth0 up
ip netns exec green ip link set dev lo up
ip netns exec red ip link set dev r-veth0 up
ip netns exec red ip link set dev lo up

# add IP addresses to the devices:
ip netns exec green ip addr add 8.8.8.8/24 dev g-veth0
ip netns exec red ip addr add 8.8.8.9/24 dev r-veth0

# bind interface to Linux bridges
brctl addif g-bridge g-veth0-bis
brctl addif g-bridge g-veth1-bis
brctl addif r-bridge r-veth0-bis
brctl addif r-bridge r-veth1-bis

# bind OVS
ovs-vsctl add-port ovs-br g-veth1
ovs-vsctl add-port ovs-br r-veth1

# first test:
ip netns exec red ping 8.8.8.8