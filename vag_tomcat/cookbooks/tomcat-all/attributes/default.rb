# O.S. related settings
default['tomcat-all']['user'] = 'tomcat'
default['tomcat-all']['group'] = 'tomcat'

# Tomcat related settings
## installation
default['tomcat-all']['version'] = '7.0.53'
default['tomcat-all']['install_directory'] = '/opt'
## configuration
default['tomcat-all']['shutdown_port'] = '8005'
default['tomcat-all']['port'] = '8080'
default['tomcat-all']['max_threads'] = '100'
default['tomcat-all']['min_spare_threads'] = '10'
default['tomcat-all']['java_opts'] = '-d64 -server -Djava.awt.headless=true'

# MySQL Connector/J
default['tomcat-all']['mysql']['enabled'] = true
default['tomcat-all']['mysql']['url'] = 'http://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-5.1.30.tar.gz'
default['tomcat-all']['mysql']['checksum'] = '1986baca293f998f9ecfe8a56e6e832825048a9c466cc5b5ed91940407f1210d'

# Oracle OJDBC7
default['tomcat-all']['oracle']['enabled'] = true
default['tomcat-all']['oracle']['url'] = 'http://svbcn071.gft.com:50080/ojdbc7.jar'
