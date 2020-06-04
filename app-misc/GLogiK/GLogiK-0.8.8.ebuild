# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit user

DESCRIPTION="Daemon to handle special features on gaming keyboards"
HOMEPAGE="https://framagit.org/netfab/GLogiK"
SRC_URI="https://download.tuxfamily.org/glogik/${P}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

REQUIRED_USE="^^ ( consolekit elogind systemd )"
IUSE="consolekit debug elogind +qt5 systemd"

DEPEND="
	>=dev-libs/boost-1.64.0
	dev-libs/libevdev
	virtual/libusb:1
	sys-apps/dbus
	qt5? (
		dev-qt/qtcore:5
		dev-qt/qtgui:5
		dev-qt/qtwidgets:5
	)
	virtual/libudev
	x11-libs/libICE
	x11-libs/libSM"
RDEPEND="
	consolekit? ( >=sys-auth/consolekit-1.1.2 )
	elogind? ( sys-auth/elogind )
	systemd? ( sys-apps/systemd )
	${DEPEND}"

DOCS=( AUTHORS COPYING ChangeLog NEWS VERSION README )

src_configure() {
	econf \
		$(use_enable debug) \
		$(use_enable qt5)
}

pkg_postinst() {
	enewgroup plugdev
	enewgroup glogiks
	enewuser glogikd -1 -1 /dev/null "plugdev"
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