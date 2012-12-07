echo "Create the temporary installation directory for extracting the ZIP archives and the final installation directory."
.\cm7_install_prepare_dirs.ps1

# .\Downloads\database\createDB.bat

echo "Extract all ZIP archives to the temporary installation directory."
.\cm7_install_copy_components.ps1

echo "Run the Tomcat installation scripts. These scripts copy the Tomcat installations to the final installation directory. The Tomcat scripts expect an JRE installation in %JAVA_HOME%\jre. Since we are installed a JRE, the Tomcat scripts will fail, so we temporarily unset JAVA_HOME. The Tomcat scripts will then use the JRE_HOME environment variable to find the JRE installation."
.\cm7_install_services.ps1
.\cm7_start_services.ps1

echo "Run the installation scripts for all command line tools."
.\cm7_install_tools.ps1

echo "Install the Apache configuration."
.\cm7_install_apache_config.ps1

echo "Add the financialservices (and quickstart for testing purposes) host names to be able to test the installation."
.\cm7_install_config_etc_hosts.ps1