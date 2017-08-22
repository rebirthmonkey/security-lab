# L2 
## Ethernet
### Ethernet Frame Inspection
- using `wireshark` to capture a network interface

### Switch Forwarding DB
As shown in the figure: 
![communicate between 2 namespaces through a Linux bridge](ns-br-ns.jpg)

- using [namespace and Linux bridge creation script](ns-br-ns.sh) to create 2 namespaces and a bridge
- check the switch forwarding DB: `brctl showmacs br88`
- clean the execution environment with the [script](ns-br-ns-clean.sh)

### OpenVSwitch VLAN Network
As shown in the figure:
![VLAN networks through Linux bridges and OVS](multi-ns-br-ovs.jpg)

- using the [script1](multi-ns-br-ovs-1.sh) and [script2](multi-ns-br-ovs-2.sh) to create VLAN networks
- check connectivity between VLAN networks `sudo ip netns exec green pig 192.168.1.xx`
- clean the execution environment with the [script](multi-ns-br-ovs-clean.sh)

## ARP
### ARP Protocol Inspection
- in one terminal: `sudo tcpdump -e -n arp`
- in another terminal: `sudo apring -I eno1 172.16.254.253`

### ARP Poisoning
