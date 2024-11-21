# Copyright 2023-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..13} )

EGIT_REPO_URI="https://github.com/LostArtefacts/TRX"
EGIT_BRANCH="develop"

inherit git-r3 meson python-r1

DESCRIPTION="open source re-implementation of Tomb Raider I game"
HOMEPAGE="https://github.com/LostArtefacts/TRX"

TRX_GAME="tr1"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

DEPEND="
	>=dev-libs/uthash-2.3.0
	dev-python/json5[${PYTHON_USEDEP}]
	media-libs/libsdl2
	media-video/ffmpeg
	sys-libs/zlib"
RDEPEND="
	${DEPEND}
	${PYTHON_DEPS}"

src_configure() {
	local EMESON_SOURCE="${S}/src/${TRX_GAME}"

	local emesonargs=(
		-Dstaticdeps=false
		--bindir=/usr/share/${P}
	)
	meson_src_configure
}

src_install() {
	insinto /usr/share/${P}
	doins -r "${S}"/data/"${TRX_GAME}"/ship/.

	meson_src_install
}

pkg_postinst() {
	elog "Built binary and required files were installed into /usr/share/${P}."
	elog "You must copy this directory to your own location, then add"
	elog "the original game files into it before running ${PN}."
}
