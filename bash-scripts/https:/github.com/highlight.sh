#!/bin/bash

usage() {
    cat << EOF  
Usage: Highlights the specified search term in the console.
	highlight [-a | --app] <pcf-appName> [-t | --term] <text-to-highlight>
	[ -h | --help]
EOF
}


clear

APP=unset
TEXT=unset

while (( "$#" )); do
	case "$1" in
		-h|-help|--help)
			usage
			exit 0
			;;
		-a|--app)
			APP=$2
			shift
			;;
		-t|--term)
			TEXT=$2
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

if [[ $APP != unset ]] && [[ $TEXT != unset ]]
then
	clear
    cf logs $APP | awk '/'"$TEXT"'/ {print "\033[32m" $0 "\033[0m"} !/'"$TEXT"'/ {print "\033[0m" $0 "\033[0m"}'
fi
