#!/bin/sh

export FILES_A=$(find $CONFIGMAP_DIR -maxdepth 1 -mindepth 1 -type f -exec basename {} \;)

echo "contents of $CONFIGMAP_DIR":
ls $CONFIGMAP_DIR
echo ""
echo "contents of $VOLUME_DIR":
ls $VOLUME_DIR

echo "starting to populate $VOLUME_DIR from $CONFIGMAP_DIR"

for file in $FILES_A; do
  if [ -f $VOLUME_DIR/$file ]; then
    echo "$file exists in volume"
  fi
  if [ ! -f $VOLUME_DIR/$file ]; then
    echo "$file doesn't exist in b, copying to $VOLUME_DIR/$file"
    cp $CONFIGMAP_DIR/$file $VOLUME_DIR/$file
  fi
done

echo "finished populating $VOLUME_DIR from $CONFIGMAP_DIR"
