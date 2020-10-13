# Browser-side

## XSS (Reflected)

Cross-site scripting (XSS) attacks enable attackers to inject client-side scripts into web pages viewed by other users. A cross-site scripting vulnerability may be used by attackers to bypass access controls such as the same-origin policy. Reflected XSS arises when an application receives data in an HTTP request and includes that data within the immediate response in an unsafe way.

Ex: Enter `<script>alert(/xss/)</script>`, the script will be executed by the server.

Ref: <https://portswigger.net/web-security/cross-site-scripting#reflected-cross-site-scripting>

## XSS (DOM)

DOM (Document Object Model) XSS arises when an application contains some client-side JavaScript that processes data from an untrusted source in an unsafe way, usually by writing the data back to the DOM.

Ex:

1. Select English as the language, then you will see `default=English` in the URL.
2. Change `default=English` to `default=test`, then you will see `test` in the box.
3. Test `default=<script>alert(“Dom xss”)</script>`.
4. Test `<script>alert(document.cookie)</script>` to get cookie.

Ref: <https://medium.com/hacker-toolbelt/dvwa-1-9-xss-dom-ae1a29018f66>

## XSS (Stored)

Stored XSS occurs when a malicious script is injected directly into a vulnerable web application, which is more dangerous than reflected XSS. To successfully execute a stored XSS attack, a perpetrator has to locate a vulnerability in a web application and then inject malicious script into its server. 

Ex: 

1. Enter in the 'Message': `<script>alert(/xss/)</script>`, the script will be stored in the server.
2. Each time a user click `Sign Guestbook`, the malicious script will be executed.

Ref: <https://portswigger.net/web-security/cross-site-scripting#stored-cross-site-scripting>

## CSRF

CSRF (Cross-Site Request Forgery) is an attack that forces an end user to execute unwanted actions on a web applications in which they're currently authenticated. With a little help of social engineering (such as sending a link via email or chat), an attacker may trick the users of a web application into executing actions of the attacker’s choosing.

Ex: 

1. Fake a URL to change user's password `http://localhost:port/vulnerabilities/csrf/?password_new=password&password_conf=password&Change=Change#`
2. Hide the URL by using URL masking or domain masking to hide the attack intention.

Ref: <https://www.freebuf.com/articles/web/118352.html>

## JavaScript

JavaScript is one of the most popular languages used in websites. Due to this popularity, you can find a wide variety of JavaScript usage examples. Creating a site, it is necessary to proceed from the fact that any data received from users is unreliable and JavaScript cannot guarantee anything.

Ex: 

1. Change the *phrase* field from “ChangeMe” to “success” before opening it in a web browser, by using Burp Suite.
2. Use `'Proxy'->Options->Match and Replace` to change “ChangeMe” to “success”.
3. You'll see 'Well done' if the verification is successly bypassed, otherwise you'll see 'Invalid token' .

Ref: <https://miloserdov.org/?p=4681>

