echo "Run the Tomcat installation scripts. These scripts copy the Tomcat installations to the final installation directory."
E:\install\cm7-rls-tomcat\install.bat
E:\install\cm7-delivery-tomcat\install.bat
E:\install\cm7-solr-slave-tomcat\install.bat

echo "configure service dependencies"
sc config cm7-delivery-tomcat depend= cm7-rls-tomcat
