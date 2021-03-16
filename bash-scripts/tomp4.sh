#!/bin/bash

usage() {
    cat << EOF  
Usage: Converts a webm/avi file to mp4 on the same path(or all webm files in a folder).
	tomp4 -f <path-to-file or folder>
EOF
}

 convertToMp4() {
 	filename=$1
 	echo "converting file $filename"
 	if [[ "$filename" == *.avi ]]
 	then
		newFileName="${filename/.avi/.mp4}"
		ffmpeg -hide_banner -loglevel error -i "$filename" "$newFileName"
	elif [[ "$filename" == *.webm ]]
	then
		newFileName="${filename/.webm/.mp4}"
		ffmpeg -hide_banner -loglevel error -i "$filename" -c:v libx264 -c:a aac -strict experimental -b:a 192k "$newFileName"
	elif [[ "$filename" == *.mkv ]]
	then
		newFileName="${filename/.mkv/.mp4}"
		ffmpeg -hide_banner -loglevel error -i "$filename" "$newFileName"
	else
		echo "File $filename won't be converted"
	fi
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
    for filename in $FOLDER/*.*
    do
        convertToMp4 "${filename}"
    done
elif [[ -f $FOLDER ]]; then
	convertToMp4 "${FOLDER}"
else
    echo "Folder/file [$FOLDER] is not valid"
    exit 1
fi

echo "Convertion finished :)"
