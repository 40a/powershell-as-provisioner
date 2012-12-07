$target_server=$args[0]
echo "copy all files from zip-repo to $target_server downloads"
rm -r \\$target_server.jdg.co.za\e$\downloads
mkdir \\$target_server.jdg.co.za\e$\downloads
$files=Get-ChildItem ..\..\boxes\target\zip-repo
mkdir \\$target_server\e$\downloads\zip-repo
foreach ($file in $files) { cp ..\..\boxes\target\zip-repo\$file \\$target_server.jdg.co.za\e$\downloads\zip-repo }

echo "copy all necessary scripts to $target_server jdg_scripts"
rm -r \\$target_server.jdg.co.za\e$\jdg_scripts
mkdir \\$target_server.jdg.co.za\e$\jdg_scripts

Copy-Item ..\..\jdg_scripts\* \\$target_server.jdg.co.za\e$\jdg_scripts

