# 认证

## Brute Force

2. Use Burp Suite

   [Burp Suite](https://portswigger.net/burp) is a set of tools used for penetration testing of web applications.

   1. Install [Burp Suite Pro](https://www.ddosi.com/b429/)
   2. Follow the documentation [Burp Suite Doc](https://t0data.gitbooks.io/burpsuite/content/), set the proxy of the browser and then capture the packet by using `'Proxy' -> 'Intercept'`.
   3. Copy the packet content to `'Intruder'` and attack the parameter 'password=' by adding $ around its value.
   4. Use `'Payloads'` to guess the password according to a dictionary (can be created manually).
   5. The response packet will vary in length which indicates the potential password.
   
2. SQL injection

   Insert malicious SQL statements into an entry field of execution. SQL injection must exploit a security vulnerability in an application's software, for example, when user input is either incorrectly filtered for string literal escape characters embedded in SQL statements or user input is not strongly typed and unexpectedly executed. 

   Ex:

   * Username: `admin' or '1'='1` (without password)
   * Username: `admin' #` (without password)

Ref: <https://www.freebuf.com/articles/web/116437.html>

## Insecure CAPTCHA

Insecure CAPTCHA (Completely Automated Public Turing Test to Tell Computers and Humans Apart) stands for insecure verification process.

1. Use [Google recaptcha](https://www.google.com/recaptcha/admin/create) to create a reCAPTCHA
   * reCAPTCHA type: reCAPTCHA v2 -> "I'm not a robot" Checkbox
   * Domains: localhost
2. Add the publickey and the private key to /var/www/html/config/config.inc.php (in docker)
   * Install vim in docker, `apt-get update`, `apt-get install vim`
   * `$_DVWA[ 'recaptcha_public_key' ] = 'xxxxxxxxxxxxx'`
   * `$_DVWA[ 'recaptcha_private_key' ] = 'xxxxxxxxxxxxx'`
3. Bypass the verification process
   1. Enter password, click `'change'`
   2. Capture the packet by using `'Proxy' -> 'Intercept'` in Burp Suite.
   3. Change `"step=1"` to `"step=2"` to bypass the verification step and then the password will be changed.

Ref: <https://www.freebuf.com/articles/web/119692.html>

## Weak Session IDs

When a user access a site, the server will ditribute a session ID to the user. Then the user can save it to the cookie and revisit the site without entering a password again. If we can predict what future cookies will be distributed and what previous cookies were generated. With these cookies we can steal a valid user session and impersonate a legitimate user to steal information or carry out some malicious operations.

1. Click `Generate` multiple times and use Burp Suite to capture and forward the packets. 
2. Use `'Proxy'->'HTTP history'->'Response'->'Headers'` to see the change of the header `Set-cookie`.
3. One can easily predict the change of the value `dvwaSeesion`, which can be also confirmed by the source html code. 

Ref: <https://braincoke.fr/write-up/dvwa/dvwa-weak-session-i-ds/>

