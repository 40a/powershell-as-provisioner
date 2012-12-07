# --------------- FIELDS -----------------------------------
$strDownloadDir	 = "C:\Users\Administrator\Downloads"
$strProgramFiles = "C:\Program Files"

# ElasticSearch
$strElasticSearch = "elasticsearch-0.19.9"
Write-Output "-------- Download and extract ElasticSearch. --------"
& Start-BitsTransfer -source http://cloud.github.com/downloads/elasticsearch/elasticsearch/$strElasticSearch.zip -destination $strDownloadDir
& 7z x $strDownloadDir\$strElasticSearch.zip
& mv $strElasticSearch $strProgramFiles

& Write-Output "-------- Download and extract the ElasticSearch service wrapper. --------"
& Start-BitsTransfer -source https://github.com/elasticsearch/elasticsearch-servicewrapper/archive/master.zip -destination $strDownloadDir"\elasticsearch-servicewrapper.zip"
& 7z x $strDownloadDir\elasticsearch-servicewrapper.zip
& Write-Output "-------- Move the wrapper to the ElasticSearch installation directory and cleanup. --------"
& mv elasticsearch-servicewrapper-*\service "$strProgramFiles\$strElasticSearch\bin"
& rm -r elasticsearch-servicewrapper-*

& Write-Output "-------- Download and extract the 64-bat Java Service Wrapper for Windows. --------"
& Start-BitsTransfer -source http://www.krenger.ch/wp-content/uploads/2012/06/wrapper-windows-x86-64-3.5.15.zip -destination $strDownloadDir
& 7z x $strDownloadDir\wrapper-windows-x86-64-3.5.15.zip

& Write-Output "-------- Move the 64-bit service wrapper to the ElasticSearch installation directory and cleanup. --------"
& mv wrapper-windows-x86-64-3.5.15\bin\wrapper.exe $strProgramFiles\$strElasticSearch\bin\service\exec\elasticsearch-windows-x86-64.exe
& mv wrapper-windows-x86-64-3.5.15\lib\wrapper.dll $strProgramFiles\$strElasticSearch\bin\service\lib\wrapper-windows-x86-64.dll
& rm -r wrapper-windows-x86-64-3.5.15

& Write-Output "-------- Adjust the ElasticSearch configuration files. --------"
& cp "$strProgramFiles\$strElasticSearch\bin\service\elasticsearch.bat" "$strProgramFiles\$strElasticSearch\bin\service\elasticsearchInstall.bat"
(cat "$strProgramFiles\$strElasticSearch\bin\service\elasticsearchInstall.bat") | %{$_ -replace "`"%_WRAPPER_EXE%`" -c %_WRAPPER_CONF%", "`"%_WRAPPER_EXE%`" -i %_WRAPPER_CONF%"} | Set-Content "$strProgramFiles\$strElasticSearch\bin\service\elasticsearchInstall.bat"
(cat "$strProgramFiles\$strElasticSearch\bin\service\elasticsearch.conf") | %{$_ -replace "<Path to ElasticSearch Home>", "$strProgramFiles\elasticsearch-0.19.9"} | Set-Content "$strProgramFiles\$strElasticSearch\bin\service\elasticsearch.conf"
(cat "$strProgramFiles\$strElasticSearch\bin\service\elasticsearch.conf") | %{$_ -replace "-Des.path.home=%ES_HOME%", "-Des.path.home=`"%ES_HOME%`""} | Set-Content "$strProgramFiles\$strElasticSearch\bin\service\elasticsearch.conf"

& Write-Output "-------- Create a directory for logs. Install and start the ElasticSearch service. --------"
& md "$strProgramFiles\$strElasticSearch\logs"
& Start-Process -FilePath $strProgramFiles"\$strElasticSearch\bin\service\elasticsearchInstall.bat" -Wait
& Start-Service ElasticSearch