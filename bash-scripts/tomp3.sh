#!/bin/bash

usage() {
    cat << EOF  
Usage: Converts a webm file to mp3 on the same path(or all webm files in a folder).
	tomp3 -f <path-to-file or folder>
EOF
}

 convertToMp3() {
 	filename=$1
 	newFileName="${filename/.ogg/.mp3}"
	newFileName="${newFileName/.m4a/.mp3}"
	echo "converting file $filename"
    ffmpeg -hide_banner -loglevel error -i $filename -vn -ar 44100 -ac 2 -b:a 320k $newFileName
}



while (( "$#" )); do
	case "$1" in
		-h|-help|--help)
			usage
			exit 0
			;;
		-f)
			FOLDER=$2
			shift
			;;
		*)
	     	PARAMS="$PARAMS $1"
	      	shift
	      	;;
	esac
done

if [[ -d $FOLDER ]]; then
	if [[ "$FOLDER" == *"/" ]]; then
		FOLDER=${FOLDER%?}
	fi
    echo "Converting files in directory"
    for filename in $FOLDER/*.webm; do
        convertToMp3 "${filename}"
    done
elif [[ -f $FOLDER ]]; then
	convertToMp3 "${FOLDER}"
else
    echo "Folder/file [$FOLDER] is not valid"
    exit 1
fi

echo "Convertion finished :)"
