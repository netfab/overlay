# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGIT_REPO_URI="https://framagit.org/netfab/GLogiK.git/"
EGIT_BRANCH="dev"

inherit autotools git-r3 user

DESCRIPTION="Daemon to handle special features on gaming keyboards"
HOMEPAGE="https://framagit.org/netfab/GLogiK"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

REQUIRED_USE="^^ ( consolekit elogind systemd )
	gui? ( dbus )"
IUSE="consolekit +dbus debug elogind +gui systemd"

DEPEND="
	>=dev-libs/boost-1.64.0
	dev-libs/libevdev
	virtual/libusb:1
	dbus? (
		sys-apps/dbus
		x11-libs/libICE
		x11-libs/libSM
		x11-libs/libX11
		x11-libs/libXtst
		gui? (
			dev-qt/qtcore:5
			dev-qt/qtgui:5
			dev-qt/qtwidgets:5
		)
	)
	virtual/libudev
"
RDEPEND="
	acct-group/glogiks
	acct-user/glogikd
	consolekit? ( >=sys-auth/consolekit-1.1.2 )
	elogind? ( sys-auth/elogind )
	systemd? ( sys-apps/systemd )
	${DEPEND}"

DOCS=( AUTHORS COPYING ChangeLog NEWS.md VERSION README.md )

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	econf \
		$(use_enable dbus) \
		$(use_enable debug) \
		$(use_enable gui qt5) \
		${EXTRA_ECONF}
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
