echo "stop all tomcats"
.\cm7_stop_services.ps1

echo "clear DBs and reset feeders"
E:\coremedia\cm7-cms-tools\bin\cm64.exe schemaaccess dropAll
E:\coremedia\cm7-mls-tools\bin\cm64.exe schemaaccess dropAll
E:\coremedia\cm7-rls-tools\bin\cm64.exe schemaaccess dropAll
E:\coremedia\cm7-caefeeder-preview-tools\bin\cm64.exe resetcaefeeder reset
E:\coremedia\cm7-caefeeder-live-tools\bin\cm64.exe resetcaefeeder reset

echo "start all tomcats"
.\cm7_start_services.ps1