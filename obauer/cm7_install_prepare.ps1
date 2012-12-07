echo "Install and configure the environment for 7-zip"
# Start-BitsTransfer -Source "http://downloads.sourceforge.net/project/sevenzip/7-Zip/9.20/7z920-x64.msi?r=http%3A%2F%2Fwww.7-zip.org%2F&ts=1349696827&use_mirror=freefr" -Destination '.\Downloads\7z920-x64.msi'
# msiexec.exe /i "C:\Users\Administrator\Downloads\7z920-x64.msi" /qn
[Environment]::SetEnvironmentVariable("PATH", "$env:PATH;$env:ProgramFiles\7-Zip", "Machine")
$env:PATH="$env:PATH;$env:ProgramFiles\7-Zip"

echo "Install and configure the environment for Java7 64bit"
#Start-BitsTransfer -Source http://javadl.sun.com/webapps/download/AutoDL?BundleId=68736 -Destination .\Downloads\jre-7u9-windows-x64.exe
#.\Downloads\jre-7u9-windows-x64.exe /s
[Environment]::SetEnvironmentVariable("JAVA_HOME", "C:\Program Files\Java\jdk1.7.0_07", "Machine")
[Environment]::SetEnvironmentVariable("JRE_HOME", "C:\Program Files\Java\jre7", "Machine")
$env:JAVA_HOME="C:\Program Files\Java\jdk1.7.0_07"
$env:JRE_HOME="C:\Program Files\Java\jre7"

echo "Create the temporary installation directory for extracting the ZIP archives and the final installation directory."

md E:\install
md E:\coremedia
