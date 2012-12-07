# --------------- FIELDS -----------------------------------
$strDownloadDir	  = "C:\Users\Administrator\Downloads"
$strProgramFiles  = "C:\Program Files"
$strApacheDir     = "C:\Apache2.2"

# Apache
Write-Output "-------- Download and install Apache. --------"
& Start-BitsTransfer -source "http://mirror.netcologne.de/apache.org/httpd/binaries/win32/httpd-2.2.22-win32-x86-openssl-0.9.8t.msi" -destination $strDownloadDir
& msiexec.exe /q /i $strDownloadDir"\httpd-2.2.22-win32-x86-openssl-0.9.8t.msi" INSTALLDIR="$strApacheDir" SERVERADMIN="test@localhost"
& Start-Sleep -Seconds 30 # wait for installation completion
& Write-Output "-------- Enable all required modules in the Apache configuration. --------"
(cat strApacheDir\conf\httpd.conf) | %{$_ -replace "#LoadModule rewrite_module modules/mod_rewrite.so", "LoadModule rewrite_module modules/mod_rewrite.so"} | Set-Content $strApacheDir\conf\httpd.conf
(cat strApacheDir\conf\httpd.conf) | %{$_ -replace "#LoadModule ssl_module modules/mod_ssl.so", "LoadModule ssl_module modules/mod_ssl.so"} | Set-Content $strApacheDir\conf\httpd.conf
(cat strApacheDir\conf\httpd.conf) | %{$_ -replace "#Include conf/extra/httpd-ssl.conf", "Include conf/extra/httpd-ssl.conf"} | Set-Content $strApacheDir\conf\httpd.conf
(cat strApacheDir\conf\httpd.conf) | %{$_ -replace "#LoadModule proxy_module modules/mod_proxy.so", "LoadModule proxy_module modules/mod_proxy.so"} | Set-Content $strApacheDir\conf\httpd.conf
(cat strApacheDir\conf\httpd.conf) | %{$_ -replace "#LoadModule proxy_balancer_module modules/mod_proxy_balancer.so", "LoadModule proxy_balancer_module modules/mod_proxy_balancer.so"} | Set-Content $strApacheDir\conf\httpd.conf
(cat strApacheDir\conf\httpd.conf) | %{$_ -replace "#LoadModule proxy_ajp_module modules/mod_proxy_ajp.so", "LoadModule proxy_ajp_module modules/mod_proxy_ajp.so"} | Set-Content $strApacheDir\conf\httpd.conf

& Write-Output "-------- Create and install a certificate and a key for SSL communication. --------"
& Start-Process -FilePath "$strApacheDir\bin\openssl.exe"  -ArgumentList "req -new -x509 -nodes -out server.crt -keyout server.key -config $strApacheDir\conf\openssl.cnf -batch" -Wait
& mv server.crt, server.key $strApacheDir\conf

& Write-Output "-------- Install and start the Apache service. --------"
& Start-Process -FilePath "$strApacheDir\bin\httpd.exe" -ArgumentList "-k install -n Apache2.2" -Wait
#New-Service -Name $ServiceName -BinaryPathName $fullPath -StartupType Automatic
& Start-Service Apache2.2