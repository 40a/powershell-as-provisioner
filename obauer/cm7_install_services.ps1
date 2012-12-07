echo "Run the Tomcat installation scripts. These scripts copy the Tomcat installations to the final installation directory. The Tomcat scripts expect an JRE installation in %JAVA_HOME%\jre. Since we are installed a JRE, the Tomcat scripts will fail, so we temporarily unset JAVA_HOME. The Tomcat scripts will then use the JRE_HOME environment variable to find the JRE installation."
#cp Env:\JAVA_HOME Env:\OLD_JAVA_HOME
#rm Env:\JAVA_HOME
E:\install\cm7-solr-master-tomcat\install.bat
E:\install\cm7-solr-slave-tomcat\install.bat
E:\install\cm7-mls-tomcat\install.bat
E:\install\cm7-cms-tomcat\install.bat
E:\install\cm7-rls-tomcat\install.bat
E:\install\cm7-wfs-tomcat\install.bat
E:\install\cm7-caefeeder-preview-tomcat\install.bat
E:\install\cm7-caefeeder-live-tomcat\install.bat
E:\install\cm7-studio-tomcat\install.bat
E:\install\cm7-delivery-tomcat\install.bat
#cp Env:\OLD_JAVA_HOME Env:\JAVA_HOME
#rm Env:\OLD_JAVA_HOME

echo "configure service dependencies"
sc config cm7-delivery-tomcat depend= cm7-rls-tomcat
sc config cm7-studio-tomcat depend= cm7-cms-tomcat