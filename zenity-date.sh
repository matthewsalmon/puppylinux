#!/bin/bash  
PHOTO_DIR=$(zenity --calendar \
  --date-format="%Y.%m.%d" \
  --title="Photo directory" \
  --text="Please choose a directory:" \
  --day=3 \
  --month=5 \
  --year=2026)
 
if [ $? -eq 0 ]; then  
  zenity --info --text="Will create: $PHOTO_DIR"  
fi

if [ ! -d "$PHOTO_DIR" ]; then
	echo "Creating $PHOTO_DIR !"
	mkdir $PHOTO_DIR
else
	echo "$PHOTO_DIR folder exists!"
fi
