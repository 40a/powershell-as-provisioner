# --------------- FIELDS -----------------------------------
$strDownloadDir	 	= "C:\Users\Administrator\Downloads"
$strInstallDir 		= "C:\install"
$strCoreMediaDir	= "C:\CoreMedia"


Write-Output "-------- Create the temporary installation directory for extracting the ZIP archives and the final installation directory. --------"
md $strInstallDir
md $strCoreMediaDir

Write-Output "-------- Create the database schemas and users. The MySQL password is admin. --------"
Start-Process -FilePath $strDownloadDir\database\mysql\createDB.bat -Wait

Write-Output "-------- Extract all ZIP archives to the temporary installation directory. --------"
$files=Get-ChildItem $strDownloadDir\zip-repo
foreach ($file in $files) { & 7z x -y -o$strInstallDir\$($file.BaseName) $file.FullName }

Write-Output "-------- Change the repository URL for the Delivery Tomcat to point to the Master Live Server because we are not going to use a Replication Live Server in this setup. --------"
(gc $strInstallDir\cm7-delivery-tomcat\INSTALL\cm7-delivery-tomcat.properties) | %{$_ -replace "48080", "42080"} | sc $strInstallDir\cm7-delivery-tomcat\INSTALL\cm7-delivery-tomcat.properties

Write-Output "-------- Copy the Tomcat base installation to the final installation directory."
cp -r $strInstallDir\cm7-tomcat-installation $strCoreMediaDir\cm7-tomcat-installation

Write-Output "-------- Run the Tomcat installation scripts. These scripts copy the Tomcat installations to the final installation directory. The Tomcat scripts expect an JRE installation in %JAVA_HOME%\jre. Since we are installed a JRE, the Tomcat scripts will fail, so we temporarily unset JAVA_HOME. The Tomcat scripts will then use the JRE_HOME environment variable to find the JRE installation. --------"
cp Env:\JAVA_HOME Env:\OLD_JAVA_HOME
rm Env:\JAVA_HOME
$strInstallDir\cm7-solr-master-tomcat\install.bat
$strInstallDir\cm7-mls-tomcat\install.bat
$strInstallDir\cm7-cms-tomcat\install.bat
$strInstallDir\cm7-wfs-tomcat\install.bat
$strInstallDir\cm7-caefeeder-preview-tomcat\install.bat
$strInstallDir\cm7-caefeeder-live-tomcat\install.bat
$strInstallDir\cm7-studio-tomcat\install.bat
$strInstallDir\cm7-delivery-tomcat\install.bat
cp Env:\OLD_JAVA_HOME Env:\JAVA_HOME
rm Env:\OLD_JAVA_HOME

Write-Output "-------- Start the Tomcats --------"
Start-Service cm7-solr-master-tomcat
Start-Service cm7-mls-tomcat
Start-Service cm7-cms-tomcat
Start-Service cm7-wfs-tomcat
Start-Service cm7-caefeeder-preview-tomcat
Start-Service cm7-caefeeder-live-tomcat
Start-Service cm7-studio-tomcat
Start-Service cm7-delivery-tomcat

Write-Output "-------- Run the installation scripts for all command line tools. --------"
$tools = ls $strInstallDir | where {$_ -match "tools"}
foreach ($tool in $tools) { & "$($tool.FullName)\install.bat"  }


Write-Output "-------- Extract, import and publish the content."
&7z x -o$strInstallDir C:\Users\Administrator\Downloads\content-users.zip
$strCoreMediaDir\cm7-cms-tools\bin\cm64 serverimport -u admin -p admin -r $strInstallDir\content
$strCoreMediaDir\cm7-cms-tools\bin\cm64 bulkpublish -u admin -p admin -a -b -c

Write-Output "-------- Install the Apache configuration. --------"
md C:\var\log\httpd
$strInstallDir\cm7-studio-apache\install.bat
$strInstallDir\cm7-delivery-apache\install.bat
Add-Content "C:\Apache2.2\conf\httpd.conf" "Include conf.d/*"
Restart-Service Apache2.2

Write-Output "-------- Add the Blueprint host names to be able to test the installation. --------"
Add-Content 'C:\Windows\System32\Drivers\etc\hosts' '127.0.0.1 studio.media.localhost studio.corporation.localhost studio.quickstart.localhost preview.media.localhost preview.corporation.localhost preview.quickstart.localhost editor.localhost media.localhost corporation.localhost quickstart.localhost'
