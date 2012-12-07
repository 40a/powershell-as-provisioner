# Enable all required modules in the Apache configuration .
(cat C:\Apache2.2\conf\httpd.conf) | %{$_ -replace "#LoadModule rewrite_module modules/mod_rewrite.so", "LoadModule rewrite_module modules/mod_rewrite.so"} | Set-Content C:\Apache2.2\conf\httpd.conf
(cat C:\Apache2.2\conf\httpd.conf) | %{$_ -replace "#LoadModule ssl_module modules/mod_ssl.so", "LoadModule ssl_module modules/mod_ssl.so"} | Set-Content C:\Apache2.2\conf\httpd.conf
(cat C:\Apache2.2\conf\httpd.conf) | %{$_ -replace "#Include conf/extra/httpd-ssl.conf", "Include conf/extra/httpd-ssl.conf"} | Set-Content C:\Apache2.2\conf\httpd.conf
(cat C:\Apache2.2\conf\httpd.conf) | %{$_ -replace "#LoadModule proxy_module modules/mod_proxy.so", "LoadModule proxy_module modules/mod_proxy.so"} | Set-Content C:\Apache2.2\conf\httpd.conf
(cat C:\Apache2.2\conf\httpd.conf) | %{$_ -replace "#LoadModule proxy_balancer_module modules/mod_proxy_balancer.so", "LoadModule proxy_balancer_module modules/mod_proxy_balancer.so"} | Set-Content C:\Apache2.2\conf\httpd.conf
(cat C:\Apache2.2\conf\httpd.conf) | %{$_ -replace "#LoadModule proxy_http_module modules/mod_proxy_http.so", "LoadModule proxy_http_module modules/mod_proxy_http.so"} | Set-Content C:\Apache2.2\conf\httpd.conf
(cat C:\Apache2.2\conf\httpd.conf) | %{$_ -replace "#LoadModule proxy_ajp_module modules/mod_proxy_ajp.so", "LoadModule proxy_ajp_module modules/mod_proxy_ajp.so"} | Set-Content C:\Apache2.2\conf\httpd.conf
(cat C:\Apache2.2\conf\httpd.conf) | %{$_ -replace "#LoadModule headers_module modules/mod_headers.so", "LoadModule headers_module modules/mod_headers.so"} | Set-Content C:\Apache2.2\conf\httpd.conf


# Create and install a certificate and a key for SSL communication.
C:\Apache2.2\bin\openssl.exe req -new -x509 -nodes -out server.crt -keyout server.key -config C:\Apache2.2\conf\openssl.cnf -batch
mv .\server.crt .\server.key C:\Apache2.2\conf