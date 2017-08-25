# L3 Networking
## IP 

## ICMP Protocol Inspection
### Error Destination Unreachable (type=3): port Unreachable (code=3)
- on 192.168.88.2: `sudo tcpdump -i enp0s3 -s 1500 -vv icmp or port tftp`
- on 192.168.88.2: `tftp`
  - `get 192.168.88.3:/foo`

### Error Time Exceeded (type=11)
- on host: `sudo wireshark` for ICMP traffics
- on host: `traceroute www.google.com`

## ICMP-related Hacking
### Ping of Death Attack
Form an IPv4 datagram which is too large to crash the hosting system
- on 192.168.88.3: `sudo ping -l 65510 192.168.88.3` (-l: length)
- we can see that a lot of packets are lost!!

### Land Attack
An ICMP message contains a source and destination IP address equal to the victim's is sent to the victim 
- ???

### Smurf Attack
This uses ICMP with broadcast destination address to induce a large number of computers to respond. 
Generally this attack is mounted by setting the source IP address to the intended victim's address.
- ???
