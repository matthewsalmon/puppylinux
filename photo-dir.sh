#!/bin/bash

DIRECTORY=$(date +%Y.%m.%d)

echo "Date is $DIRECTORY ..."

# test for links?

if [ ! -d "$DIRECTORY" ]; then
	echo "Creating $DIRECTORY !"
	mkdir $DIRECTORY
else
	echo "$DIRECTORY folder exists!"
fi
