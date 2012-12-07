[string]$Settings = "settings.ps1xml"
		
		
# ---------------------------------------------------------------------------------------------------------------------------
#  -- MESSENGER
		function writeError($message) {
			Write-Host $message -Foreground Red
			break;
		}
		
		function writeMessage($message) {
			Write-Host $message -Foreground White
		}
		
		
# ---------------------------------------------------------------------------------------------------------------------------
# -- INSTALLER
		function install($app) {
			try {
				$fileDestination = $downloadDir+"\"+$app.binary
				
				if (!(Test-Path $fileDestination)){
					Import-Module BitsTransfer
					writeMessage ("Downloading " + $app.name + " from " + $app.url)
					Start-BitsTransfer -Source $app.url -Destination $fileDestination
				} else {
					writeMessage("'$fileDestination' already exists")
				}
								
				if ($app.type -ceq "msi") {
					writeMessage("Installation by MSI")
					Start-Process -FilePath msiexec -ArgumentList /i, $fileDestination, /qn -Wait
				}
					
				if ($app.type -ceq "exec"){
					writeMessage("Installation by EXEC")
					Start-Process -FilePath $fileDestination -ArgumentList "/s" -wait
				}
					
				if ($app.type -ceq "zip"){
					writeMessage("Unzip " + $fileDestination)			
										
					$shell = new-object -com shell.application;
					$zip = $shell.NameSpace($fileDestination);
					foreach($item in $zip.items()){
						$shell.Namespace($downloadDir).copyhere($item)
					}
				}
			}
			catch {
				writeError ("Could not deploy. EXCEPTION: {1}" -f $_)
			}
		}
		
		function getName($zipfile){
				return $zipfile.substring(0,$zipfile.Length-4) # remove .zip 
		}
		
# --------------------------------------------------------------------------------------------------------------------------------------------
# -- XML LOADER
		writeMessage ("Reading settings file at {0}." -f $settings)
		if ((test-path $settings) -eq $false) {
			writeError ("Could not find settings file at {0}." -f $settings)
		}
		$xml = new-object System.Xml.XmlDocument
		try {
			$xml.LoadXml( (gc $settings) )
			if ($xml.applications.count -gt -0) {
					writeError ("Could not read settings file at {0} or no <applications> sections found." -f $settings)
			}
		}
		catch {
			writeError ("Could not parse {0}. EXCEPTION: {1}" -f $settings, $_)
		}

# --------------------------------------------------------------------------------------------------------------------------------------------
# -- NOW
	# -- registering fields
	$downloadDir		= $xml.settings.common.directories.download
	$programDir			= $xml.settings.common.directories.program
	$mysql 				= $xml.SelectSingleNode("//applications[@name='mysql']")
	$mongodb			= $xml.SelectSingleNode("//applications[@name='mongodb']")
	$java 				= $xml.SelectSingleNode("//applications[@name='java']")
	$elasticSearch		= $xml.SelectSingleNode("//applications[@name='elasticsearch']")
	$esServiceWrapper	= $xml.SelectSingleNode("//applications[@name='elasticsearch-service-wrapper']")
	$esWindowsWrapper	= $xml.SelectSingleNode("//applications[@name='elasticsearch-windows-wrapper']")
	$apache				= $xml.SelectSingleNode("//applications[@name='apache']")
							
	# -- MYSQL
	if($mysql){
		$mysqlRoot = $programDir+"\MySQL\"+$mysql.version
		writeMessage("Download, install and start mysql.")
		install($mysql)
		Start-Process -FilePath $mysqlRoot"\bin\MySQLInstanceConfig.exe" -ArgumentList "-i -q -n$mysql.version -p $mysqlRoot -v5.5.29 ServiceName=MySQL55 RootPassword=admin" -wait
		writeMessage("Add the MySQL installation directory to the PATH environment variable.")
		[Environment]::SetEnvironmentVariable("PATH", "$env:PATH;$mysqlRoot\bin", "Machine")
		$env:PATH="$env:PATH;$mysqlRoot\bin"
	}
		
	# -- MONGODB
	if($mongodb){
		$mongoDBProgramName = getName($mongodb.binary)
		$mongoProgramDir	= $programDir+"\"+$mongoDBProgramName+"\bin\mongod.exe"
    
		writeMessage("Download, install and start MongoDB.")
		foreach ($dir in $mongodb.directories.directory) {
		
		
			if (!(Test-Path $dir)){
				md $dir
			} else{
				writeMessage($dir + " already exists")
			}		
		}
		
		install($mongodb)
		mv $downloadDir\$mongoDBProgramName $programDir
		Start-Process  -FilePath $mongoProgramDir -ArgumentList "--install --logpath C:\var\log\mongodb\mongod.log --dbpath C:\var\lib\mongodb" -Wait
		Start-Service MongoDB
	}
		
	# -- JAVA
	if($java){
		writeMessage("Download, install and start Java.")
		install($java)
		writeMessage("Create JAVA_HOME and JRE_HOME environment variables.")
		[Environment]::SetEnvironmentVariable("JAVA_HOME", "$programDir\Java\jre7", "Machine")
		[Environment]::SetEnvironmentVariable("JRE_HOME", "$programDir\Java\jre7", "Machine")
		$env:JAVA_HOME="$programDir\Java\jre7"
		$env:JRE_HOME="$programDir\Java\jre7"
	}
    
	# -- ELASTICSEARCH
	if($elasticSearch){
		$esFileName			= getName($elasticSearch.binary)
		$esServiceFileName	= getName($esServiceWrapper.binary)
		$esWindowsFileName 	= getName($esWindowsWrapper.binary)		
		$esDir 				= $programDir+"\"+$esFileName
		$esServiceDir 		= $esDir+"\bin\service"
        
		echo " "
		echo " -------- Preparing ElasticSearch"
		install($elasticSearch)
		echo "...move FROM $downloadDir\$esFileName TO $programDir"
		mv $downloadDir\$esFileName $programDir
        
		echo " "
		echo " --------  Preparing ElasticSearch Service Wrapper"
		install($esServiceWrapper)
		echo "...move FROM $downloadDir\$esServiceFileName-master\service TO $esDir\bin"
		mv $downloadDir\$esServiceFileName-master\service $esDir\bin
        
		echo " "
		echo " --------  Preparing ElasticSearch Windows Wrapper"
		install($esWindowsWrapper)
		echo "...move FROM $downloadDir\$esWindowsFileName\bin\wrapper.exe TO $esServiceDir\exec\elasticsearch-windows-x86-64.exe"
		mv $downloadDir\$esWindowsFileName\bin\wrapper.exe $esServiceDir\exec\elasticsearch-windows-x86-64.exe
		echo "...move FROM $downloadDir\$esWindowsFileName\lib\wrapper.dll TO $esServiceDir\lib\wrapper-windows-x86-64.dll"
		mv $downloadDir\$esWindowsFileName\lib\wrapper.dll $esServiceDir\lib\wrapper-windows-x86-64.dll
        
	 	echo " "
		echo " --------  Configuring ElasticSearch Properties"
		cp $esServiceDir\elasticsearch.bat $esServiceDir\elasticsearchInstall.bat
		(cat $esServiceDir\elasticsearchInstall.bat) | %{$_ -replace "`"%_WRAPPER_EXE%`" -c %_WRAPPER_CONF%", "`"%_WRAPPER_EXE%`" -i %_WRAPPER_CONF%"} | Set-Content $esServiceDir\elasticsearchInstall.bat
		(cat $esServiceDir\elasticsearch.conf) | %{$_ -replace "<Path to ElasticSearch Home>", "$programDir\elasticsearch-0.19.9"} | Set-Content $esServiceDir\elasticsearch.conf
		(cat $esServiceDir\elasticsearch.conf) | %{$_ -replace "-Des.path.home=%ES_HOME%", "-Des.path.home=`"%ES_HOME%`""} | Set-Content $esServiceDir\elasticsearch.conf
        
		md $esDir\logs
		Start-Process -FilePath $esServiceDir\elasticsearchInstall.bat -Wait
		Start-Service ElasticSearch
	}
	
	#-- APACHE
	if($apache){
		$apacheDir 	= $apache.directory
		$apacheBin 	= $apache.binary
		$apacheName	= $apache.filename
	
		#install($apache)
		Import-Module BitsTransfer
		writeMessage ("Downloading " + $apacheBin + " from " + $apache.url)
		Start-BitsTransfer -Source $apache.url -Destination $downloadDir\$apacheBin
				
		Start-Process -FilePath "msiexec" -ArgumentList "/q /i $downloadDir\$apacheBin INSTALLDIR=$apacheDir SERVERADMIN='test@localhost'" -Wait
				
		(cat $apacheDir\conf\httpd.conf) | %{$_ -replace "#LoadModule rewrite_module modules/mod_rewrite.so", "LoadModule rewrite_module modules/mod_rewrite.so"} | Set-Content $apacheDir\conf\httpd.conf
		(cat $apacheDir\conf\httpd.conf) | %{$_ -replace "#LoadModule ssl_module modules/mod_ssl.so", "LoadModule ssl_module modules/mod_ssl.so"} | Set-Content $apacheDir\conf\httpd.conf
		(cat $apacheDir\conf\httpd.conf) | %{$_ -replace "#Include conf/extra/httpd-ssl.conf", "Include conf/extra/httpd-ssl.conf"} | Set-Content $apacheDir\conf\httpd.conf
		(cat $apacheDir\conf\httpd.conf) | %{$_ -replace "#LoadModule proxy_module modules/mod_proxy.so", "LoadModule proxy_module modules/mod_proxy.so"} | Set-Content $apacheDir\conf\httpd.conf
		(cat $apacheDir\conf\httpd.conf) | %{$_ -replace "#LoadModule proxy_balancer_module modules/mod_proxy_balancer.so", "LoadModule proxy_balancer_module modules/mod_proxy_balancer.so"} | Set-Content $apacheDir\conf\httpd.conf
		(cat $apacheDir\conf\httpd.conf) | %{$_ -replace "#LoadModule proxy_ajp_module modules/mod_proxy_ajp.so", "LoadModule proxy_ajp_module modules/mod_proxy_ajp.so"} | Set-Content $apacheDir\conf\httpd.conf
    
		Start-Process -FilePath "$apacheDir\bin\openssl.exe"  -ArgumentList "req -new -x509 -nodes -out server.crt -keyout server.key -config $apacheDir\conf\openssl.cnf -batch" -Wait
		mv server.crt, server.key $apacheDir\conf
    
		Start-Process -FilePath "$apacheDir\bin\httpd.exe" -ArgumentList "-k install -n $apacheName" -Wait
		Start-Service $apacheName
	}