#####
#generates and deploys a war file into tomcat server
####
#!/bin/bash
clear
echo "X stopping tomcat(in case is up)"
/f/Userdata/servers/tomcat/imer-8.5.20/bin/shutdown.sh >/dev/null 2>&1
cd PATH_TO_YOUR_PROJECT
echo "X generating war file"
mvn -T 1C --offline package -DskipTests
echo "X deleting webapp from tomcat"
rm -rf PATH_TO_TOMCAT/webapps/*
echo "X cleaning logfile from tomcat"
cp /dev/null PATH_TO_TOMCAT/logs/catalina.out
echo "X opening log window(press ctrl+c to close window)"
/c/Program\ Files/Git/git-bash.exe -c "tail -f PATH_TO_TOMCAT/logs/catalina.out" &
echo "X opening App log window(press ctrl+c to close window)"
/c/Program\ Files/Git/git-bash.exe -c "tail -f tail -f PATH_TO_YOUR_LOG_FILE" &
echo "X copying war to webapps"
cp PATH_TO_YOUR_WAR_FILE PATH_TO_TOMCAT/webapps/
echo "X starting tomcat"
PATH_TO_TOMCAT/bin/startup.sh >/dev/null
#echo "deploying war file to tomcat"
#curl --upload-file /f/Userdata/repositories/svn/imer/QC14627/startom/MonthEndReports/MonthEndReportsCore/target/imer.war "http://tomcat:tomcat@localhost:8080/manager/text/deploy?path=/imer&update=true"
echo "X server started"