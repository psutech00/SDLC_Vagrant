drop table sdlcevolution.USERS;
drop user 'testpaas';
drop database sdlcevolution;

create database sdlcevolution;

CREATE USER 'testpaas'@'%' IDENTIFIED BY 'testpaas';
GRANT ALL PRIVILEGES ON sdlcevolution.* TO 'testpaas'@'%';
