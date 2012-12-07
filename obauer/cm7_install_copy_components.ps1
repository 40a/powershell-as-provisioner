# Extract all ZIP archives to the temporary installation directory.
$files=Get-ChildItem E:\downloads\zip-repo
foreach ($file in $files) { & 7z x -y -oE:\install\$($file.BaseName) $file.FullName }

# Copy the Tomcat base installation to the final installation directory.
cp -r E:\install\cm7-tomcat-installation E:\CoreMedia\cm7-tomcat-installation
