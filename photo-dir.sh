#!/bin/bash

# script to dreate a dated directory

DIRECTORY=$(date +%Y.%m.%d)

echo "Date is $DIRECTORY ..."

# test for links?

if [ ! -d "$DIRECTORY" ]; then
	echo "Creating $DIRECTORY !"
	mkdir $DIRECTORY
else
	echo "$DIRECTORY folder exists!"
fi
