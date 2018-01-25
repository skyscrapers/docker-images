#!/bin/sh

export FILES_A=$(find $CONFIGMAP_DIR -maxdepth 1 -mindepth 1 -type f -exec basename {} \;)

for file in $FILES_A; do
	if [ -f $VOLUME_DIR/$file ]; then
		echo "$file exists in volume"
	fi
	if [ ! -f $VOLUME_DIR/$file ]; then
		echo "$file doesn't exist in b, copying to $VOLUME_DIR/$file"
		cp $CONFIGMAP_DIR/$file $VOLUME_DIR/$file
	fi
done
