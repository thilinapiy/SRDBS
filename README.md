# Secure and Redundant Data Backup System

## Description

    SRDBS is a enterprise class data backup system. System can perform a fully automatic backup to several disaster 
    recovery (DR) sites. This system requires minimum of there clouds to od its backup process.

## Installation

### Get source code

		git clone https://github.com/thilinapiy/SRDBS.git

		or

		Download a zip file of the code and unzip it.

		Then go to the root directory of the project and type

		in windows
			> mvn clean package

		in Linux
			$ mvn clean package

### Install binary distribution

            Unzip/untar the compressed file in to a secure location. Then set the path
            variable as

            in Windows
                > SRDBS_HOME=<path to the installation>
                     eg: SRDBS_HOME=C:\Users\Thilina\Desktop\SRDBS-1.0-SNAPSHOT
                > set path=%SRDBS_HOME%\bin;%PATH%

            in Linux

                $ export SRDBS_HOME=<path to the installation>
                    eg: export SRDBS_HOME=/home/thilina/SRDBS-1.0-SNAPSHOT
                $ export PATH=$SRDBS_HOME/bin:$PATH

### Run the server

        > srdbsstart.bat

        or

        $ srdbsstart

### To see the UI visit:

        https://localhost:8080

## Dependencies

- [__Oracle__ Java JDK 7] (http://www.oracle.com/technetwork/java/javase/downloads/java-se-jdk-7-download-432154.html)

- [Maven __3.0__] (http://maven.apache.org/download.html)

## Developers

- [Thilina Piyasundara] (http://thilina.org)

- Chanaka Yapa

- Isanka Gayan

- Prabodha Amarasinghe
