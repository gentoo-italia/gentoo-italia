# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

#
# Original Author: Henry Gebhardt <hsggebhardt@googlemail.com>
# Purpose: Provide common functions for systemd integration.
#
# Bugs to http://bugs.gentoo.org/show_bug.cgi?id=318365, or
# hsggebhardt@googlemail.com.
#

IUSE="systemd"

PDEPEND="systemd? ( sys-apps/systemd )"

# doservices: install systemd .service files. Usage is 'doservices files....'.
doservices() {
	[[ -z "${1}" ]] && die "usage: doservices <files...>"
	insinto "/lib/systemd/system"
	for i in "$@" ; do
		doins "$i" || die "doservices failed to install '$i'"
	done
}

# use_with_systemdsystemunitdir: Echo configure option depending on systemd
# USE flag.
use_with_systemdsystemunitdir() {
	if use systemd; then
		echo "--with-systemdsystemunitdir=/lib/systemd/system"
	else
		echo "--without-systemdsystemunitdir"
	fi
}
