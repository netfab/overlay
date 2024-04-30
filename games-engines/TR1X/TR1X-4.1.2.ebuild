# Copyright 2023-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..12} )

inherit meson python-r1

DESCRIPTION="open source implementation of the classic Tomb Raider I game (1996)"
HOMEPAGE="https://github.com/LostArtefacts/TR1X"
SRC_URI="https://github.com/LostArtefacts/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"
RESTRICT="mirror"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

# git required by build system
DEPEND="
	dev-python/json5[${PYTHON_USEDEP}]
	dev-vcs/git
	media-libs/libsdl2
	media-video/ffmpeg
	sys-libs/zlib"
RDEPEND="
	${DEPEND}
	${PYTHON_DEPS}"
BDEPEND=""

src_configure() {
	local emesonargs=(
		--bindir=/usr/share/${P}
		-Dstaticdeps=false
	)
	meson_src_configure
}

src_install() {
	insinto /usr/share/${P}
	doins -r "${S}"/data/ship/.

	meson_src_install
}

pkg_postinst() {
	elog "Built binary and required files were installed into /usr/share/${P}."
	elog "You must copy this directory to your own location, then add"
	elog "the original game files into it before running ${PN}."
}
