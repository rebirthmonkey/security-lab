# Network Scanning

## Idle Scan
- on the attacker 192.168.88.2: `sudo nmap -sI 192.168.88.4 -Pn -p20-25,110 -r --packet-trace -v 192.168.88.3`
- the target: 192.168.88.3
- the zombie: 192.168.88.4
- more detailed about this attack can be found [here](https://nmap.org/book/idlescan.html)