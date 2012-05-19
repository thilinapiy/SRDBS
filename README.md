# Secure and Redundant Data Backup System

## Description

    SRDBS is a enterprise class data backup system. System can perform a fully automatic backup to several disaster 
    recovery (DR) sites. This system requires minimum of there clouds to od its backup process.

## Installation

### Get source code
    git clone https://github.com/thilinapiy/SRDBS.git

### Go to the root directory of the project and type

   - in windows

        > mvn clean assembly:assembly

   - in Linux

        $ mvn clean assembly:assembly

### Run the server
        
        Maven will create a distributable zip file in the generated target folder.
        Unzip the compressed file in to a secure location. Then go into that folder
        and type,

        > bin\start.bat
        
        or 
        
        $ bin/start

### To see the UI visit:

        https://localhost:8080

## Dependencies

- __Oracle__ Java JDK 7

- Maven __3.0__

## Developers

- Thilina Piyasundara

- Chanaka Yapa

- Isanka Gayan

- Prabodha Amarasinghe
