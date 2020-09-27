# Cryptography

## OpenSSL
### Display
- `openssl version`
- `openssl list-standard-commands`: display all commands
- `openssl list-cipher-commands`: display cipher algorithms

### Symmetric Encryption
- create a file: `touch plain.txt`, `echo "I love OpenSSL" > plain.txt`
- `openssl enc -aes-256-cbc -in plain.txt -out encrypted.bin`: use a password instead of a secret key to encrypt
- `openssl enc -aes-256-cbc -d -in encrypted.bin -pass pass:XXX`: decrypt

### Asymmetric Encryption
- `openssl genrsa -out key.pem 1024`: create a private key
- `openssl rsa -in key.pem -pubout -out pub-key.pem`: extract public key from the private key
- `openssl rsautl -encrypt -in plain.txt -inkey pub-key.pem -pubin -out rsa-encrypted.bin`
- `openssl rsautl -decrypt -in rsa-encrypted.bin -inkey key.pem -out plain2.txt`

### Hash
- `openssl dgst -sha1 -out digest.hash plain.txt`

### Digital signature
- `openssl rsautl -sign -in digest.hash -out signature -inkey key.pem`: create signature
- `openssl rsautl -verify -in signature -out digest.hash -inkey pub-key.pem -pubin`: verify signature

### Certificate
- `CDIR=openssl version -d`
- `openssl s_client -CApath $CDIR -connect www.digicert.com:443 > digicert.out 2>1`: get raw certificate data
- `grep "return code" digicert.out`: check return status
- `openssl x509 -in digicert.out -out digicert.pem`: get the certificate
- `openssl x509 -in digicert.pem -text`: display the certificate content
- `CERT=DigiCertHighAssuranceEVCA-1.pem`, `openssl ocsp -issuer $CERT -cert digicert.pem -url http://ocsp.digicert.com -VAfile $CERT -no_nonce -text`: verify the certificate

