####
#Util shorcuts for the terminal, must be added to the bashprofile file
####

#git aliases
alias gst='git status'
alias repo='cd /f/Userdata/repositories/git/'
alias tree='mvn dependency:tree -Dverbose | clip'
alias commits='git shortlog | grep -E '"'"'^[ ]+\w+'"'"' | wc -l'
alias commits-by-user='git shortlog | grep -E '"'"'^[^ ]'"'"''
#regular commands
alias ls='ls -lat'
###PUTTY
alias dev1='putty.exe -ssh USER@IP:PORT -pw PASSWORD &'
#git patch
export GIT_SSH_COMMAND='ssh -o KexAlgorithms=+diffie-hellman-group1-sha1'
#PATH
export PATH="${PATH}:/f/Userdata/servers/apacheAnt/bin"
#Maven
export MAVEN_HOME="YOUR_PATH"
export M2_HOME="YOUR_PATH"
#export MAVEN_OPTS="-Xms6m -Xmx80m"
#Tomcat
alias stop-imer-tomcat=PATH_TO_TOMCAT/bin/shutdown.sh >/dev/null
alias start-imer-tomcat=PATH_TO_TOMCAT/bin/startup.sh >/dev/null

