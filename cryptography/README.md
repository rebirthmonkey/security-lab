# Cryptography

## OpenSSL
### Display
- `openssl version`
- `openssl list-standard-commands`: display all commands
- `openssl list-cipher-commands`: display cipher algorithms

### Symmetric Encryption
- `touch plain.txt`, `echo "I love OpenSSL" > plain.txt`: create a file
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


## SSH Key for GitHub
- [Adding a new SSH key to your GitHub account](https://docs.github.com/en/free-pro-team@latest/github/authenticating-to-github/adding-a-new-ssh-key-to-your-github-account)


## HTTPS Server with Keys and Certificates
- [HTTPS Server with Keys and Certificates](https-server/README.md)

