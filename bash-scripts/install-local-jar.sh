##########
#Installs a jar file from local system into your local repository(.m2)
##########
#!/bin/bash
clear
echo -e '******************************************'
echo -e '\e[0m******\e[5mWELCOME TO JAR DEPLOYMENT\e[0m***********'
echo -e '******************************************'
printf 'please provide the jar path:'
read -r jarPath
printf 'please provide the groupId:'
read -r groupId
printf 'please provide the artifactId:'
read -r artifactId
printf 'please provide the version:'
read -r version
clear
echo 'Installing artifact'
mvn install:install-file -Dfile=$jarPath -DgroupId=$groupId -DartifactId=$artifactId -Dversion=$version -Dpackaging=jar
