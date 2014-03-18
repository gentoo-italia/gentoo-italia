#!/bin/sh

sudo chown paradox:paradox * -R
git add -A
git commit -m "$1"
git push origin master
