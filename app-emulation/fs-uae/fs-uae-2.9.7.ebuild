# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

MY_CHAN="devel"
MY_PV="${PV}dev2"
MY_P="${P}dev2"

DESCRIPTION="Amiga emulator based on WinUAE emulation code"
HOMEPAGE="https://fs-uae.net/"
SRC_URI="https://fs-uae.net/fs-uae/${MY_CHAN}/${MY_PV}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="dev-libs/glib:2
	media-libs/freetype:2
	media-libs/glew:0=
	media-libs/libmpeg2
	media-libs/libpng:0
	media-libs/libsdl2[joystick,opengl,video,X]
	media-libs/openal
	sys-libs/zlib
	virtual/libintl
	virtual/opengl"
DEPEND="${RDEPEND}
	app-arch/zip
	sys-devel/gettext
	virtual/pkgconfig"

S="${WORKDIR}/${MY_P}"
