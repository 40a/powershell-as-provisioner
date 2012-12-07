# Install the Apache configuration.
md E:\var\log\httpd
E:\install\cm7-studio-apache\install.bat
E:\install\cm7-delivery-apache\install.bat
Add-Content 'C:\Apache2.2\conf\httpd.conf' 'Include e:\coremedia\cm7-delivery-apache\*.conf'
Add-Content 'C:\Apache2.2\conf\httpd.conf' 'Include e:\coremedia\cm7-studio-apache\*.conf'
Restart-Service Apache2.2