echo "Create the temporary installation directory for extracting the ZIP archives and the final installation directory."
..\cm7_install_prepare.ps1

echo "Extract all ZIP archives to the temporary installation directory."
.\cm7_install_copy_components.ps1

echo "Run the Tomcat installation scripts. These scripts copy the Tomcat installations to the final installation directory. The Tomcat scripts expect an JRE installation in %JAVA_HOME%\jre. Since we are installed a JRE, the Tomcat scripts will fail, so we temporarily unset JAVA_HOME. The Tomcat scripts will then use the JRE_HOME environment variable to find the JRE installation."
.\cm7_install_services.ps1

echo "Run the installation scripts for all command line tools."
.\cm7_install_tools.ps1

