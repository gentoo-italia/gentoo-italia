#!/bin/sh

mkdir $1
cp -r /usr/portage/$1/$2/ $1
sudo chmod 777 -R $1/$2
rm $1/$2/{Manifest,metadata.xml}
