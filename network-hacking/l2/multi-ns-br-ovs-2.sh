#!/usr/bin/env bash

# cleanup Linux bridge settings:
ip netns exec green ip addr del 8.8.8.8/24 dev g-veth0
ip netns exec red ip addr del 8.8.8.9/24 dev r-veth0

# setup the green DHCP namespace with VLAN100:
ip netns add g-dhcp
ovs-vsctl add-port ovs-br g-tap
ovs-vsctl set interface g-tap type=internal
ovs-vsctl set port g-tap tag=100
ovs-vsctl set port g-veth1 tag=100
ip link set g-tap netns g-dhcp
ip netns exec g-dhcp ip link set dev lo up
ip netns exec g-dhcp ip link set dev g-tap up
ip netns exec g-dhcp ip addr add 192.168.1.8/24 dev g-tap
ip netns exec g-dhcp dnsmasq --interface=g-tap --dhcp-range=192.168.1.10,192.168.1.20,255.255.255.0
ip netns exec green dhclient g-veth0
sleep 3

# setup the red DHCP namespace with VLAN200:
ip netns add r-dhcp
ovs-vsctl add-port ovs-br r-tap
ovs-vsctl set interface r-tap type=internal
ovs-vsctl set port r-tap tag=200
ovs-vsctl set port r-veth1 tag=200
ip link set r-tap netns r-dhcp
ip netns exec r-dhcp ip link set dev lo up
ip netns exec r-dhcp ip link set dev r-tap up
ip netns exec r-dhcp ip addr add 192.168.1.8/24 dev r-tap
ip netns exec r-dhcp dnsmasq --interface=r-tap --dhcp-range=192.168.1.10,192.168.1.20,255.255.255.0
ip netns exec red dhclient r-veth0
sleep 3

# show new IP address in each namespace:
ip netns exec green ip addr
ip netns exec red ip addr

# test:
# ip netns exec red ping 192.168.1.x
