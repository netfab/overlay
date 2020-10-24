# Copyright 1999-2020 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit user

DESCRIPTION="Daemon to handle special features on gaming keyboards"
HOMEPAGE="https://framagit.org/netfab/GLogiK"
SRC_URI="https://download.tuxfamily.org/glogik/${P}/${P}.tar.gz"
RESTRICT="mirror"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

REQUIRED_USE="^^ ( elogind systemd )"
IUSE="debug elogind +gui systemd"

DEPEND="
	>=dev-libs/boost-1.64.0
	dev-libs/libevdev
	virtual/libusb:1
	sys-apps/dbus
	gui? (
		dev-qt/qtcore:5
		dev-qt/qtgui:5
		dev-qt/qtwidgets:5
	)
	virtual/libudev
	x11-libs/libICE
	x11-libs/libSM
	x11-libs/libX11
	x11-libs/libXtst"
RDEPEND="
	acct-group/glogiks
	acct-user/glogikd
	elogind? ( sys-auth/elogind )
	systemd? ( sys-apps/systemd )
	${DEPEND}"

DOCS=( AUTHORS COPYING ChangeLog NEWS VERSION README )

src_configure() {
	econf \
		$(use_enable debug) \
		$(use_enable gui qt5)
}

pkg_postinst() {
	elog "Users who wants to use the GLogiKs desktop service must be in the glogiks group."
	elog "See https://wiki.gentoo.org/wiki/Knowledge_Base:Adding_a_user_to_a_group"
	elog
	elog "After adding users to this group, and also after ${PN} installation,"
	elog "you may need to reload the DBus daemon configuration :"
	elog	"(openRC users)"
	elog "   # /etc/init.d/dbus reload"
}

src_install() {
	emake DESTDIR="${D}" install
	einstalldocs
	doinitd "${S}"/data/init/openrc/glogikd
}
