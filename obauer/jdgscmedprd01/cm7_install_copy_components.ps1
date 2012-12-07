echo "Extract necessary ZIP archives to the temporary installation directory."
$files=Get-ChildItem E:\downloads\zip-repo\*.* -include cm7-rls*,cm7-delivery*,cm7-tomcat-installation*,cm7-solr-slave*
foreach ($file in $files) { & 7z x -y -oE:\install\$($file.BaseName) $file.FullName }

echo "Copy the Tomcat base installation to the final installation directory."
cp -r E:\install\cm7-tomcat-installation E:\CoreMedia\cm7-tomcat-installation
