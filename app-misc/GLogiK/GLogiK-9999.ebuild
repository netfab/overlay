# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://framagit.org/netfab/GLogiK.git/"
EGIT_BRANCH="dev"

inherit git-r3 meson tmpfiles udev xdg-utils

DESCRIPTION="Daemon to handle special features on gaming keyboards"
HOMEPAGE="https://netfab.frama.io/pages/glogik/"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""

REQUIRED_USE="
	^^ ( elogind systemd )
	libnotify? ( notification )
	notification? ( dbus libnotify )
	gui? ( dbus qt6 )
	qt6? ( gui )
"
IUSE="+dbus debug elogind +gui +hidapi +libnotify +notification +qt6 systemd"

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
			qt6? (
				dev-qt/qtbase:6[gui,widgets]
			)
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

src_configure() {
	local emesonargs=(
		$(meson_use dbus)
		$(meson_use debug)
		$(meson_use hidapi)
		$(meson_use libnotify)
		$(meson_use notification notifications)
		$(meson_use qt6)
		$(meson_use qt6 systray)
		-Ddocdir="${EPREFIX}/usr/share/doc/${PF}"
	)

	meson_src_configure
}

src_install() {
	meson_src_install

	if use gui ; then
		# do NOT compress license file (must be readable by Qt gui application)
		docompress -x "${EPREFIX}/usr/share/doc/${PF}/COPYING"
	fi
}

pkg_postinst() {
	udev_reload
	xdg_icon_cache_update

	elog "Users who wants to use the desktop service and the Qt GUI must be in the glogiks group."
	elog "See https://wiki.gentoo.org/wiki/Knowledge_Base:Adding_a_user_to_a_group"

	if use debug ; then
		tmpfiles_process GLogiK.conf
	fi
}

pkg_postrm() {
	udev_reload
	xdg_icon_cache_update
}
