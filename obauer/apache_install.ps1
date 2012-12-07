echo "Apache installable has to be E:\software\httpd-2.2.22-win32-x86-openssl-0.9.8t.msi"
msiexec.exe /q /i "E:\software\httpd-2.2.22-win32-x86-openssl-0.9.8t.msi" INSTALLDIR="C:\Apache2.2" SERVERADMIN="admin@jdfs.co.za"

echo "Install the Apache service"
Start-Sleep -s 120
C:\Apache2.2\bin\httpd.exe -k install -n "Apache2.2"