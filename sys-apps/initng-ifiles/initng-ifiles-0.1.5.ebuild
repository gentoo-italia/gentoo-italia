# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/initng-ifiles/initng-ifiles-0.1.5.ebuild,v 1.1 2009/02/08 19:36:44 vapier Exp $

DESCRIPTION="A next generation init replacement"
HOMEPAGE="http://initng.org/"
SRC_URI="http://download.initng.org/initng-ifiles/v${PV:0:3}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sparc ~x86"
IUSE=""

RDEPEND="sys-apps/initng"
DEPEND="${RDEPEND}
	>=dev-util/cmake-2.1"

plugin_warning() {
	if [[ -z ${INITNG_FILES} ]] ; then
		einfo "If you want to customize the list of initng files, please"
		einfo "set the INITNG_FILES variable in your make.conf."
	fi
}

pkg_setup() {
	plugin_warning
}

src_compile() {
	local x default_opts valid_opts cmake_opts=""
	valid_opts=$(sed -n   '/^OPTION/        s:.*(\([[:alpha:]_]*\).*:\1:p' CMakeLists.txt)
	default_opts=$(sed -n '/^OPTION(.*ON)$/ s:.*(\([[:alpha:]_]*\).*:\1:p' CMakeLists.txt)
	INITNG_FILES=$(echo ${INITNG_FILES} | tr '[:lower:]' '[:upper:]')
	INITNG_FILES=${INITNG_FILES:-${default_opts}}
	for x in ${valid_opts} ; do
		if hasq ${x} ${INITNG_FILES} || hasq ${x#INSTALL_} ${INITNG_FILES} ; then
			cmake_opts="${cmake_opts} -D${x}=ON"
		else
			cmake_opts="${cmake_opts} -D${x}=OFF"
		fi
	done
	cmake -DCMAKE_INSTALL_PREFIX=/ ${cmake_opts} || die
	emake || die
}

src_install() {
	emake install DESTDIR="${D}" || die
	dodoc AUTHORS ChangeLog README
}
