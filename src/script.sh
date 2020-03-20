#!/bin/bash

	# If no arguments are supplied
	if [ $# -eq 0 ]; then
	    echo "No arguments supplied!"
	    exit
	fi

	# If supplied file does not exist
	if [ ! -f "$1" ]; then
	    echo "File not found!"
	    exit
	fi

ffmpeg=./vendor/ffmpeg

FILE=$1

fullFileName=$(basename ${FILE})
fileName=${fullFileName%.*}
filePath=$(dirname "$1")

# Generate cover image
$ffmpeg -y -i "$1" -vframes 1 ${filePath}/${fileName}.jpg
# Generate MP4
$ffmpeg -y -i "$1" -c:v libx264 -pix_fmt yuv420p -profile:v baseline -level 3.0 -crf 22 -preset veryslow ${filePath}/${fileName}.mp4
