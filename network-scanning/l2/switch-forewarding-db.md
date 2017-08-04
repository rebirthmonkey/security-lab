# Linux Bridge Forewarding DB

## Prerequisite

Install Linux Bridge

```bash
sudo apt install bridge-utils
sudo su
```


## Manipulation

Create 2 network namespaces
```bash
ip netns add red
ip netns add green
```

Create 2 veth paris
```bash
ip link add dev r-veth0 type veth peer name r-veth0-bis
ip link add dev g-veth0 type veth peer name g-veth0-bis
```

Set veth to the namespaces
```bash
ip link set r-veth0 netns red
ip link set g-veth0 netns green
```

Create and setup a Linux bridge
```bash
brctl addbr ns-bridge
brctl show 
brctl showmacs ns-bridge
brctl addif ns-bridge r-veth0-bis
brctl addif ns-bridge g-veth0-bis
```

Activate all the devices
```bash
ip link set dev r-veth0-bis up
ip link set dev g-veth0-bis up
ip link set dev ns-bridge up
ip netns exec red ip link set dev lo up
ip netns exec red ip link set dev r-veth0 up
ip netns exec green ip link set dev lo up
ip netns exec green ip link set dev g-veth0 up
```

Associate IP addresses to the devices
```bash
ip netns exec red ip addr add 8.8.8.8/24 dev r-veth0
ip netns exec green ip addr add 8.8.8.9/24 dev g-veth0
```


## Test
```bash
brctl show 
brctl showmacs ns-bridge
ip netns exec red ping 8.8.8.9
brctl show 
brctl showmacs ns-bridge
```

