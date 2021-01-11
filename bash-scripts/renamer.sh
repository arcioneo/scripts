#!/bin/bash

usage() {
    cat << EOF  
Usage: Renames files inside a folder.
	rename -f | --folder <path-to-folder>
	[ -p | --prefix   <value> ] 
	[ -q | --postfix  <value> ]
	[ -t | --trim ]
	[ -r | --replace  <value> ]
	[ -w | --with  <value> ]
	[ -h | --help]

EOF
}


FOLDER=unset
PREFIX=unset
POSTFIX=unset
TRIM=0
REPLACE=unset
WITH=unset

while (( "$#" )); do
	case "$1" in
		-h|-help|--help)
			usage
			exit 0
			;;
		-f|-folder|--folder)
			FOLDER=$2
			shift
			;;
		-p|-prefix|--prefix)
			PREFIX=$2
			shift
			;;
		-q|-postfix|--postfix)
			POSTFIX=$2
			shift
			;;
		-t|-trim|--trim)
			TRIM=1
			shift
			;;
		-r|-replace|--replace)
			REPLACE=$2
			shift
			;;
		-w|-with|--with)
			WITH=$2
			shift
			;;
		-*|--*=)
		    echo "Error: Unsupported flag $1" >&2
		    usage
		    exit 1
		    ;;
		*)
	     	PARAMS="$PARAMS $1"
	      	shift
	      	;;
	esac
done

if [ "$FOLDER" = "unset" ]; then
 	echo "You need to provide a folder path"
 	usage
	exit 0
fi

if [[ "$FOLDER" == *"/" ]]; then
	FOLDER=${FOLDER%?}
fi

for filename in "$FOLDER"/*; do

	fullFileName=${filename##*/}
	path=${filename%/*}
	filenameNoExtension=${fullFileName%.*}
	extension=${filename#*.}
    
	if [ $TRIM = 1 ]; then
		filenameNoExtension=$(echo "$filenameNoExtension" | xargs)
		extension=$(echo "$extension" | xargs)
	fi

	if [[ $REPLACE != unset ]] && [[ $WITH != unset ]]
	then
		filenameNoExtension=${filenameNoExtension//$REPLACE/$WITH}
	fi

	if [ $PREFIX != unset ]; then
		filenameNoExtension="$PREFIX$filenameNoExtension"
	fi

	if [ $POSTFIX != unset ]; then
		filenameNoExtension="$filenameNoExtension$POSTFIX"
	fi

	finalName="$path/$filenameNoExtension.$extension"

	mv "$filename" "$finalName"
	echo "Changed name $filename to $finalName"
done