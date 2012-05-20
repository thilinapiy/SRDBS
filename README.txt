Secure and Redundant Data Backup System

Description

	SRDBS is a enterprise class data backup system. System can perform a fully automatic backup to several disaster 
	recovery (DR) sites. This system requires minimum of there clouds to od its backup process.

Installation

	Get source code

		git clone https://github.com/thilinapiy/SRDBS.git

		or

		Download a zip file of the code and unzip it.
		Go to the root directory of the project and type

		in windows
			> mvn clean assembly:assembly

		in Linux
			$ mvn clean assembly:assembly

Run the server

	Maven will create a distributable zip file in the generated target folder.
	Unzip the compressed file in to a secure location. Then go into that folder
	and type,
	
	> bin\start.bat
	
	or
	
	$ bin/start

To see the UI visit:

	https://localhost:8080

Dependencies
	Oracle Java JDK 7
		(http://www.oracle.com/technetwork/java/javase/downloads/java-se-jdk-7-download-432154.html)
	Maven 3.0
		(http://maven.apache.org/download.html)
Developers

	Thilina Piyasundara
	Chanaka Yapa
	Isanka Gayan
	Prabodha Amarasinghe