# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

DESCRIPTION="Amiga emulator based on WinUAE emulation code"
HOMEPAGE="https://fs-uae.net/"
SRC_URI="https://fs-uae.net/fs-uae/devel/${PV}dev/${P}dev.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="app-arch/zip
	dev-libs/glib:2
	media-libs/freetype:2
	media-libs/libmpeg2
	media-libs/libpng
	media-libs/libsdl2[joystick,opengl,X]
	media-libs/openal
	sys-devel/gettext
	sys-libs/zlib"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${P}dev"

