# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit tmpfiles qmake-utils udev xdg-utils

DESCRIPTION="Daemon to handle special features on gaming keyboards"
HOMEPAGE="https://netfab.frama.io/pages/glogik/"
SRC_URI="https://framagit.org/netfab/GLogiK/-/archive/${PV}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

REQUIRED_USE="
	^^ ( elogind systemd )
	libnotify? ( notification )
	notification? ( dbus libnotify )
	gui? ( dbus )
"
IUSE="+dbus debug elogind +gui +hidapi +notification +libnotify systemd"

DEPEND="
	dev-libs/boost:=
	hidapi? ( >=dev-libs/hidapi-0.10.0 )
	dbus? (
		dev-libs/libevdev
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
	notification? ( libnotify? ( >=x11-libs/libnotify-0.8.1 ) )
	virtual/libudev
	virtual/libusb:1
"
RDEPEND="
	acct-group/glogiks
	>=acct-user/glogikd-1
	elogind? ( sys-auth/elogind )
	systemd? ( sys-apps/systemd )
	${DEPEND}"

DOCS=()

RESTRICT="mirror"

src_configure() {
	export PATH="$(qt5_get_bindir):${PATH}"

	econf \
		$(use_enable dbus) \
		$(use_enable debug) \
		$(use_enable notification notifications) \
		$(use_enable libnotify) \
		$(use_enable gui qt5) \
		$(use_enable hidapi) \
		--docdir="${EPREFIX}/usr/share/doc/${PF}" \
		${EXTRA_ECONF}
}

src_install() {
	default

	doinitd "${S}"/data/init/openrc/glogikd

	if use debug ; then
		dotmpfiles data/tmpfiles.d/GLogiK.conf
	fi

	find "${ED}" -name '*.la' -delete || die '*.la files delete failure'

	if use gui ; then
		# do NOT compress license file (must be readable by qt5 gui application)
		docompress -x "${EPREFIX}/usr/share/doc/${PF}/COPYING"
	fi
}

pkg_postinst() {
	udev_reload
	xdg_icon_cache_update

	elog "Users who wants to use the GLogiKs desktop service must be in the glogiks group."
	elog "See https://wiki.gentoo.org/wiki/Knowledge_Base:Adding_a_user_to_a_group"
	elog
	elog "After adding users to this group, and also after ${PN} installation,"
	elog "you may need to reload the DBus daemon configuration :"
	elog	"(openRC users)"
	elog "   # /etc/init.d/dbus reload"

	if use debug ; then
		tmpfiles_process GLogiK.conf
	fi
}

pkg_postrm() {
	udev_reload
	xdg_icon_cache_update
}
