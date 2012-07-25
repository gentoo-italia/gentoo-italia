
EAPI=4

DESCRIPTION="Another free touch typing tutor program"
HOMEPAGE="http://klavaro.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="net-misc/curl
	>=x11-libs/gtk+-2.16.6:2
	x11-libs/gtkdatabox"

DEPEND="${RDEPEND}
	sys-devel/gettext
	|| ( dev-util/gtk-builder-convert <=x11-libs/gtk+-2.24.10:2 )"

DOCS=( AUTHORS ChangeLog NEWS README TODO )
