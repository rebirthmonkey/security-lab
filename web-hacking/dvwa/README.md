# DVWA
## Installation
- `docker pull wukongsun/dvwa:2018-04`
- `mkdir -p log/apache2`
- `docker run --name dvwa -d -p 80:80 -p 3306:3306 -e MYSQL_PASS="mypass" -v $(pwd)/log/apahce2:/var/log/apache2 wukongsun/dvwa:2018-04`
- login: admin, password: password


