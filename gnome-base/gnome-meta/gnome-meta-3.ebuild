# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="GNOME metapackage"
HOMEPAGE="https://www.gnome.org/"
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+gedit +eog +baobab +gnome-disk-utility +gnome-system-monitor +dconf-editor +gnome-tweak-tool +file-roller +gparted +gnome-terminal +chrome"

DEPEND=""
RDEPEND="${DEPEND}
gnome-base/gnome-core-libs
gnome-base/gnome-session
gnome-base/nautilus
gnome-base/gnome-shell
gnome-extra/gnome-calculator
gnome-extra/gnome-utils
gnome-system-monitor? ( gnome-extra/gnome-system-monitor )
chrome? ( gnome-extra/chrome-gnome-shell )
gedit? ( app-editors/gedit )
eog? ( media-gfx/eog )
gnome-terminal? ( x11-terms/gnome-terminal )
file-roller? ( app-arch/file-roller )
gnome-disk-utility? ( sys-apps/gnome-disk-utility )
dconf-editor? ( gnome-base/dconf-editor )
gnome-tweak-tool? ( gnome-extra/gnome-tweak-tool )
baobab? ( sys-apps/baobab )
gparted? ( sys-block/gparted )
"
