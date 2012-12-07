echo "remove current content"
.\cm7_reset_content

echo "Extract, import and publish the content."
&7z x -oE:\install E:\downloads\content-users.zip
E:\coremedia\cm7-cms-tools\bin\cm64 serverimport -u admin -p admin -r E:\install\content
E:\coremedia\cm7-cms-tools\bin\cm64 restoreusers -u admin -p admin -f E:\install\users\users.xml
E:\coremedia\cm7-cms-tools\bin\cm64 bulkpublish -u admin -p admin -a -b -c
