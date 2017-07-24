#!/bin/sh
if [ "$1" == "" ]; then
  echo "$0: Please provide a .pptx file"
  exit 1
fi
hash zip 2>/dev/null || { echo >&2 “I require zip but it’s not installed.  Aborting.”; exit 1; }
hash ffmpeg 2>/dev/null || { echo >&2 “I require ffmpeg but it’s not installed.  Aborting.”; exit 1; }
hash unzip 2>/dev/null || { echo >&2 “I require unzip but it’s not installed.  Aborting.”; exit 1; }
rm -r __temp
mkdir __temp
cd __temp
unzip ../$1
find ./ppt/media -iname “*.mov” -exec ffmpeg -i {} -acodec copy -vcodec msmpeg4v2 “{}_new.mov” \; -exec rm “{}” \; -exec mv “{}_new.mov” “{}” \;
find ./ppt/media -iname “*.avi” -exec ffmpeg -i {} -acodec copy -vcodec msmpeg4v2 “{}_new.avi” \; -exec rm “{}” \; -exec mv “{}_new.avi” “{}” \;
find ./ppt/media -iname “*.mp4” -exec ffmpeg -i {} -acodec copy -vcodec msmpeg4v2 “{}_new.mp4” \; -exec rm “{}” \; -exec mv “{}_new.mp4” “{}” \;
zip -r ../_$1 *
cd ..
rm -r __temp
echo
echo FixPoint completed. Written file : _$1
