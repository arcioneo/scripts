#!/bin/bash
#####omits numbers in file names###
###ie: 014 the sound of silence.mp3
###converted to: the sound of silence.mp3

function get_full_file_name(){
	originalIFS="$IFS"
	IFS='/'

	read -r -a paths <<< "$1"
	local length=${#paths[@]}
	echo ${paths[length - 1]}

	IFS="$originalIFS"
}

function get_name() {
	originalIFS="$IFS"
	IFS='.'

	read -r -a paths <<< "$1"
	local length=${#paths[@]}
	echo ${paths[@]:0:length-1}

	IFS="$originalIFS"
}

function get_extension() {
	originalIFS="$IFS"
	IFS='.'

	read -r -a paths <<< "$1"
	local length=${#paths[@]}
	echo ${paths[@]:length-1:length}

	IFS="$originalIFS"
}

function replace_name() {
	read -r -a soloname <<< "$1"
	# replace numbers
	noTrimmedName="${soloname//[0-9]/}"
	# replace -_
	noTrimmedName="${noTrimmedName//[-_]/}"
	# replace double blanks spaces by single one
	noTrimmedName="${noTrimmedName//  / }"
	# Strip leading space.
	trimmed="${noTrimmedName## }"
    # Strip trailing space.
    trimmed="${trimmed%% }"

    echo "$trimmed"
}

function main() {
local src="/Users/blaseduardo/Desktop/iTunes" 
local dest="/Users/blaseduardo/Desktop/target"

echo 'searching files...'
find $src -iname '*.mp3' -o -iname '*.m4a' | while read file;do
	full_name=$(get_full_file_name "$file")
	name=$(get_name "$full_name")
	extension=$(get_extension "$full_name")
	IFS='|'
	new_name=$(replace_name "$name")
	newPath="$dest/$new_name.$extension"
	mv $file $newPath
done
}

clear
main
