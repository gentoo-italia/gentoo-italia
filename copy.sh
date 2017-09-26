#!/bin/sh

mkdir $1 &>/dev/null
cp -r /usr/portage/$1/$2/ $1
sudo chown -R $USER:$USER $1/$2
rm $1/$2/{Manifest,metadata.xml}
