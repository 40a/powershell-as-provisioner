echo "Install the Apache configuration."
md E:\var\log\httpd
E:\install\cm7-delivery-apache\install.bat
Add-Content 'C:\Apache2.2\conf\httpd.conf' 'e:\coremedia\cm7-delivery-apache\*.conf'
Restart-Service Apache2.2