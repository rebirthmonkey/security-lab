# HTTPS Web Server



如果是服务端，你要生成私钥和证书，并将这两个放到你的密钥库中，并且将证书发给所有客户端。

## 生成密钥、证书

### 服务器端公钥、私钥

```bash
openssl genrsa -out server.key 1024 # 生成服务器端私钥 
openssl rsa -in server.key -pubout -out server.pem # 生成服务器端公钥 

```

### 客户端公钥、私钥

```bash
openssl genrsa -out client.key 1024 # 生成客户端私钥
openssl rsa -in client.key -pubout -out client.pem # 生成客户端公钥 
```

### 自签名 CA 证书

```bash
openssl genrsa -out ca.key 1024 # 生成 CA 私钥 
openssl req -new -key ca.key -out ca.csr # X.509 Certificate Request 
openssl x509 -req -in ca.csr -signkey ca.key -out ca.crt # X.509 self-signCertificate
```

在执行第二步时会出现：

```bash
1. ➜ keys openssl req -new -key ca.key -out ca.csr 
2. You are about to be asked to enter information that will be incorporated 
3. into your certificate request. 
4. What you are about to enter is what is called a Distinguished Name or a DN. 
5. There are quite a few fields but you can leave some blank 
6. For some fields there will be a default value, 
7. If you enter '.', the field will be left blank. 
8. \----- 
9. Country Name (2 letter code) [AU]:CN 
10. State or Province Name (full name) [Some-State]:Zhejiang 
11. Locality Name (eg, city) []:Hangzhou 
12. Organization Name (eg, company) [Internet Widgits Pty Ltd]:My CA 
13. Organizational Unit Name (eg, section) []: 
14. Common Name (e.g. server FQDN or YOUR name) []:localhost 
15. Email Address []: 
```

注意，这里的 `Organization Name (eg, company) [Internet Widgits Pty Ltd]:` 后面生成客户端和服务器端证书的时候也需要填写，不要写成一样的！！！可以随意写如：CAXXX。

然后 `Common Name (e.g. server FQDN or YOUR name) []:` 这一项，是最后可以访问的域名，我这里为了方便测试，写成 `localhost` ，如果是为了给我的网站生成证书，需要写成 `xxx.com` 。

### 服务器端证书

```bash
openssl req -new -key server.key -out server.csr # 服务器端在申请签名证书之前创建自己的 CSR 文件 
openssl x509 -req -CA ca.crt -CAkey ca.key -CAcreateserial -in server.csr -out server.crt # 向自己的 CA 机构申请证书，签名过程需要 CA 的证书和私钥参与，最终颁发一个带有 CA 签名的证书 
```

### 客户端证书

```bash
openssl req -new -key client.key -out client.csr 
openssl x509 -req -CA ca.crt -CAkey ca.key -CAcreateserial -in client.csr -out client.crt # client 端到 CA 签名
```

## 单向认证

### Server

```bash
go run https_server.go
```

### Client

#### With Certificate Verification

```bash
go run https_client.go
```

运行这个client，我们得到如下错误：
 error: Get https://localhost:8081: x509: certificate signed by unknown authority

此时服务端也给出了错误日志提示：
 2015/04/30 16:03:31 http: TLS handshake error from 127.0.0.1:62004: remote error: bad certificate

显然从客户端日志来看，go实现的Client端默认也是要对服务端传过来的数字证书进行校验的，但客户端提示：这个证书是由不知名CA签发 的！

#### Without Certificate Verification

```bash
go run https_client2.go
```

通过设置tls.Config的InsecureSkipVerify为true，client将不再对服务端的证书进行校验。

#### Certificate Verification with CA

```bash
go run https_client3.go
```

由于client端需要验证server端的数字证书，因此client端需要预先加载ca.crt，以用于服务端数字证书的校验。

## 双向认证

### Server

```bash
go run https_server2.go
```

代码通过将tls.Config.ClientAuth赋值为tls.RequireAndVerifyClientCert来实现Server强制校验client端证书。ClientCAs是用来校验客户端证书的ca certificate。

### Client

```bash
go run https_client4.go
```



## Ref

1. [Go和HTTPS](https://tonybai.com/2015/04/30/go-and-https/)
2. [https证书的验证过程与生成方法](https://www.cnblogs.com/xiohao/p/9032481.html)

