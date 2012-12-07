echo "prepare local dirs"
$source_server=$args[0]
set-variable -name mydate -value $(get-date -uformat "%Y-%m-%d")
rm -r E:\content\$source_server\export_$mydate
mkdir E:\content\$source_server\export_$mydate
mkdir E:\content\$source_server\export_$mydate\users

echo "export content from $source_server to local dir"
E:\coremedia\cm7-cms-tools\bin\cm64 serverexport -u admin -p admin -r -url http://$source_server.jdg.co.za:41080/coremedia/ior -b E:\content\$source_server\export_$mydate\content /
E:\coremedia\cm7-cms-tools\bin\cm64 dumpusers -u admin -p admin -url http://$source_server.jdg.co.za:41080/coremedia/ior -f E:\content\$source_server\export_$mydate\users\users.xml

echo "backup local content"
rm -r E:\content\local_backup\export_$mydate
mkdir E:\content\local_backup\export_$mydate
mkdir E:\content\local_backup\export_$mydate\users
E:\coremedia\cm7-cms-tools\bin\cm64 serverexport -u admin -p admin -r -b E:\content\local_backup\export_$mydate\content /
E:\coremedia\cm7-cms-tools\bin\cm64 dumpusers -u admin -p admin -f E:\content\local_backup\export_$mydate\users\users.xml

echo "reset local content"
.\cm7_reset_content.ps1

echo "import content from $source_server"
Start-Sleep -s 120
E:\coremedia\cm7-cms-tools\bin\cm64 serverimport -u admin -p admin -r E:\content\$source_server\export_$mydate\content
E:\coremedia\cm7-cms-tools\bin\cm64 restoreusers -u admin -p admin -f E:\content\$source_server\export_$mydate\users\users.xml
E:\coremedia\cm7-cms-tools\bin\cm64 bulkpublish -u admin -p admin -a -b -c

echo "restart Studio and Delivery tomcats"
Restart-Service cm7-studio-tomcat
Restart-Service cm7-delivery-tomcat

# todo: reset solr contentservr collection