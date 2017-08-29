# L4 Transport Layer
## UDP
### UDP Protocol
- on **192.168.88.2**: `nc -l 8888`
- on **192.168.88.3**: `nc 192.168.88.2 8888`

## TCP


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