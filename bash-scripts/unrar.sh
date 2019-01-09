####
#Extracts (using password) all -rar files inside the provided path(recursive)
####
#!/bin/bash
clear
files=`find YOUR_PATH -name "*.rar" -print`

for file in $files
do 
    directory=`dirname "$file"`
    cd "$directory"
    unrar x -pPASSWORD $file
done
