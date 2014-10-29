# Flyway cookbook
# Juan Larriba

default['flyway']['filename'] = 'flyway-commandline' 
default['flyway']['version'] = '3.0'
default['flyway']['base_url'] = 'http://repo1.maven.org/maven2/org/flywaydb/'#/flyway-commandline/3.0/flyway-commandline-3.0.tar.gz'
default['flyway']['installation_dir'] = '/var/lib'
default['flyway']['user'] = 'jenkins'
default['flyway']['group'] = 'jenkins'

default['flyway']['dburl'] = 'localhost'
default['flyway']['dbuser'] = 'sdlcevolution'
default['flyway']['dbpassword'] = 'apassword' 

