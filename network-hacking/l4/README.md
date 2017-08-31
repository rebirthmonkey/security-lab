# L4 Transport Layer
## UDP

## TCP
### TCP Protocol
- on **192.168.88.2**: `nc -l 8888`
- on **192.168.88.3**: `nc 192.168.88.2 8888`

### TCP Establish and Termination 
- on **host**: launch **apache2** service
- on **host**: launch **wireshark** 
- on **host**: `nc 127.0.0.1 80`, when the connection established, enter 2 time to leave `nc`

### TCP Reset
- on **host**: launch **apache2** service
- on **host**: launch **wireshark** 
- on **host**: `nc 127.0.0.1 9999`


## DNS
### Domain Lookup 
- `dig +nostats -t ANY rfc-editor.org`: `-t ANY` fetch the 4 RR types of the domain

### Host Lookup
- `host ftp.rfc-editor.org`
- `host -t any www.whitehouse.gov`: display all Canonical (alias) names

### Interactive Lookup
- `nslookup`: A RR 
  - `set type=a`
  - `berkley.edu`
- `nslookup`: PTR RR
  - `server c.in-addr-servers.arpa`
  - `set type=ptr`
  - `81.131.229.169.in-addr-arpa.`: recursive lookup
  - `server w.arin.arpa`
  - `81.131.229.169.in-addr-arpa.`: recursive lookup
  - `server adns1.berkeley.edu`
  - `81.131.229.169.in-addr-arpa.`: recursive lookup
- `nslookup`: SOA RR
  - `set type=soa`
  - `berkeley.edu.`
- `nslookup`: SOA MX
  - `server ns3.dns.ucla.edu`
  - `set type=mx`
  - `cs.ucla.edu.`

### Zone Transfer
- `hostname`: display the hostname
- `host -l xxx.`: perform a full zone transfer from a local DNS server
- `dis +short @10.0.0.1 -t ixfr=xxxxx home.`: incremental 