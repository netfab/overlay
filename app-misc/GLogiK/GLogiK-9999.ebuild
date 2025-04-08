# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://framagit.org/netfab/GLogiK.git/"
EGIT_BRANCH="dev"

inherit autotools git-r3 tmpfiles qmake-utils udev xdg-utils

DESCRIPTION="Daemon to handle special features on gaming keyboards"
HOMEPAGE="https://netfab.frama.io/pages/glogik/"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""

REQUIRED_USE="
	^^ ( elogind systemd )
	libnotify? ( notification )
	notification? ( dbus libnotify )
	gui? ( dbus )
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
			!qt6? (
				dev-qt/qtcore:5
				dev-qt/qtgui:5
				dev-qt/qtwidgets:5
			)
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

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	local myeconfargs=(
		$(use_enable dbus)
		$(use_enable debug)
		$(use_enable notification notifications)
		$(use_enable libnotify)
		$(use_enable hidapi)
		--docdir="${EPREFIX}/usr/share/doc/${PF}"
		${EXTRA_ECONF}
	)

	if use gui ; then
		if use qt6 ; then
			export PATH="$(qt6_get_bindir):${PATH}"
			myeconfargs+=(
				--enable-qt6
				--disable-qt5
			)
		else
			export PATH="$(qt5_get_bindir):${PATH}"
			myeconfargs+=(
				--disable-qt6
				--enable-qt5
			)
		fi
	else
		myeconfargs+=(
			--disable-qt6
			--disable-qt5
		)
	fi

	econf "${myeconfargs[@]}"
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

	elog "Users who wants to use the desktop service and the Qt5 GUI must be in the glogiks group."
	elog "See https://wiki.gentoo.org/wiki/Knowledge_Base:Adding_a_user_to_a_group"

	if use debug ; then
		tmpfiles_process GLogiK.conf
	fi
}

pkg_postrm() {
	udev_reload
	xdg_icon_cache_update
}
