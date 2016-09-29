Oxyus Installation Instructions

# INTRODUCTION

The main objective for installing Oxyus is to deploy oxyus.war in
a java server and start oxyus from http://yourserver/oxyus/admin.

Each server has its own deployment mechanism, so more detailed
instructions per server are provided below.

APACHE TOMCAT

	1. Copy the file oxyus.war in the webapps directory of
	   Apache Tomcat.
	   
	2. Go to Oxyus Admin located at http://yourserver/oxyus/admin
	   and instruct Oxyus which website to index.

	If hot deployment is deactivated you may deploy oxyus.war
	from the Tomcat Manager Console.

JBOSS

	1. Create a directory named oxyus.war in the deploy directory
	   of a JBoss server (normally host/default/deploy).
	   
	2. Unpack the content of the oxyus.war file in the newly created
	   deploy/oxyus.war directory.
	   
	You can use this commands as a reference:
	   
	   cd $JBOSS_HOME
	   cd server/default/deploy
	   mkdir oxyus.war
	   cd oxyus.war
	   jar xvf /oxyus/oxyus.war
	   
	3. Go to Oxyus Admin located at http://localhost/oxyus/admin
	
