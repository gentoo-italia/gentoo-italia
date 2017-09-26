#!/bin/sh
source /lib/gentoo/functions.sh

actions="digest"
if [ $# -gt 0 ]; then
	actions=$@
fi

if [ ! -f profiles/repo_name ]; then
	eerror "This directory is not a gentoo overlay"
	exit 1
fi
repo_name="$(cat profiles/repo_name)"

einfo "Running recursively \"ebuild * $actions\" on ${repo_name} overlay"
for e in */*/*.ebuild; do
	einfo "$e"
	ebuild $e $actions > /dev/null
done
