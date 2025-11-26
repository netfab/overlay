# Copyright 2023-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

LUA_COMPAT=( lua5-{1..4} )

PYTHON_COMPAT=( python3_{10..14} )

inherit lua-single meson python-r1

DESCRIPTION="Open source re-implementation of Tomb Raider I and Tomb Raider II games"
HOMEPAGE="https://github.com/LostArtefacts/TRX"
SRC_URI="
	https://github.com/LostArtefacts/TRX/archive/refs/tags/trx-${PV}.tar.gz	-> ${P}.tar.gz"

S="${WORKDIR}/TRX-trx-${PV}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""

RESTRICT="mirror"

REQUIRED_USE="${LUA_REQUIRED_USE} ${PYTHON_REQUIRED_USE}"

DEPEND="
	${LUA_DEPS}
	>=dev-libs/uthash-2.3.0
	dev-python/json5[${PYTHON_USEDEP}]
	dev-vcs/git
	media-libs/glew
	media-libs/libsdl2
	media-video/ffmpeg
	virtual/zlib"
RDEPEND="
	${DEPEND}
	${PYTHON_DEPS}"

pkg_setup() {
	lua-single_pkg_setup
}

src_configure() {
	local EMESON_SOURCE="${S}/src"

	local LUA_VERSION="$(lua_get_version)"
	LUA_VERSION="${LUA_VERSION%.*}"

	sed -i -e "s/'lua'/'lua${LUA_VERSION}'/g" ${EMESON_SOURCE}/meson.build || \
			die "Sed broke!"

	local emesonargs=(
		-Dstaticdeps=false
		--bindir=/usr/share/${PN}
	)
	meson_src_configure
}

src_install() {
	local game
	local -r TRX="${D}/usr/share/${PN}/TRX"

	meson_src_install

	for game in tr1 tr2;
	do
		insinto /usr/share/${PN}/${game}
		doins -r "${S}"/data/common/ship/.
		doins -r "${S}"/data/${game}/ship/.
		doins ${TRX}
	done

	rm ${TRX} || die "remove failed!"
}

pkg_postinst() {
	elog "Tomb Raider I  files are installed in /usr/share/${PN}/tr1."
	elog "Tomb Raider II files are installed in /usr/share/${PN}/tr2."
	elog "You must copy these directories to your own location, then add"
	elog "the original games files into them before running ${PN}."
}
