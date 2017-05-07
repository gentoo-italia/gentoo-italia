# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=6

VALA_MIN_API_VERSION="0.28"

inherit gnome2-utils vala

DESCRIPTION="Flagship desktop of Solus, designed with the modern user in mind"
HOMEPAGE="https://solus-project.com/budgie/
	https://github.com/budgie-desktop/budgie-desktop"
SRC_URI="https://github.com/${PN}/${PN}/releases/download/v${PV}/${P}.tar.xz"
IUSE="bluetooth +introspection +polkit"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
COMMON_DEPEND=">=app-i18n/ibus-1.5.11[vala]
	>=dev-libs/glib-2.46.0:2
	dev-libs/gjs
	>=dev-libs/libpeas-1.8.0:0
	>=gnome-base/gnome-desktop-3.18.0:3
	>=gnome-base/gnome-menus-3.10.1
	>=media-sound/pulseaudio-2.0
	>=net-wireless/gnome-bluetooth-3.18.0:2
	>=sys-apps/accountsservice-0.6
	>=sys-auth/polkit-0.110
	>=sys-power/upower-0.9.20
	>=x11-libs/gtk+-3.16.0:3
	>=x11-libs/libwnck-3.14.0:3
	>=x11-wm/mutter-3.18.0"
#	bluetooth? ( >=net-wireless/gnome-bluetooth-3.18.0:2 )"
DEPEND="${COMMON_DEPEND}
	$(vala_depend)
	>=dev-util/intltool-0.50.0
	dev-util/meson
	dev-util/ninja
	introspection? ( >=dev-libs/gobject-introspection-1.44.0 )"
RDEPEND="${COMMON_DEPEND}
	>=gnome-base/gnome-session-3.18.0
	x11-themes/gnome-themes-standard"

RESTRICT="mirror"

pkg_setup() {
	export MAKE=ninja
	ln -s /usr/bin/valac-$(vala_best_api_version) "${T}/valac"
	export PATH="${PATH}:${T}"
}

src_prepare() {
	eapply_user
	sed -i -e '/meson\.add_install_script/d' meson.build
	sed -i -e 's/bdugie/budgie/g' docs/meson.build
}

src_configure() {
	meson build --prefix=/usr --sysconfdir=/etc --buildtype plain \
		-Dwith-bluetooth=true \
		-Dwith-introspection=$(usex introspection true false) \
		-Dwith-polkit=true \
		-Dwith-stateless=true \
		|| die
}

src_compile() {
	cd "${S}/build"
	emake
}

src_install() {
	cd "${S}/build"
	DESTDIR="${ED}" emake install

}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	gnome2_gconf_install
	gnome2_icon_cache_update
}

pkg_postrm() {
	gnome2_gconf_uninstall
	gnome2_icon_cache_update
}
