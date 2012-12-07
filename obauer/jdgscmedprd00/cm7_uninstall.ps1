Stop-Service cm7-delivery-tomcat
Stop-Service cm7-studio-tomcat
Stop-Service cm7-caefeeder-live-tomcat
Stop-Service cm7-caefeeder-preview-tomcat
Stop-Service cm7-wfs-tomcat
Stop-Service cm7-cms-tomcat
Stop-Service cm7-mls-tomcat
Stop-Service cm7-rls-tomcat
Stop-Service cm7-solr-master-tomcat

E:\install\delivery-tomcat\uninstall-service.bat
E:\install\studio-tomcat\uninstall-service.bat
E:\install\caefeeder-live-tomcat\uninstall-service.bat
E:\install\caefeeder-preview-tomcat\uninstall-service.bat
E:\install\rls-tomcat\uninstall-service.bat
E:\install\wfs-tomcat\uninstall-service.bat
E:\install\mls-tomcat\uninstall-service.bat
E:\install\cms-tomcat\uninstall-service.bat
E:\install\solr-master-tomcat\uninstall-service.bat

rm -r E:\var\log\coremedia\*
rm -r E:\install\*
rm -r E:\CoreMedia\*