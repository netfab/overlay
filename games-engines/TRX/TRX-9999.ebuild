# Copyright 2023-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

LUA_COMPAT=( lua5-{1..4} )

PYTHON_COMPAT=( python3_{10..14} )

DESCRIPTION="Open source re-implementation of Tomb Raider I and Tomb Raider II games"
HOMEPAGE="https://github.com/LostArtefacts/TRX"

TRXDATA_COMMIT="12751b264dfc7e40dbff28ecdf37cd26619dc4cd"

TR1EXP_NAME="tr1-ub" # tr1 Unfinished Business expansion pack
TR2EXP_NAME="tr2-gm" # tr2 Golden Mask expansion pack

SRC_URI="
	https://github.com/LostArtefacts/TRX-data/archive/${TRXDATA_COMMIT}.tar.gz
		-> ${PN}-data-${TRXDATA_COMMIT}.tar.gz
	https://lostartefacts.dev/aux/tr1x/trub-music.zip -> ${PN}-${TR1EXP_NAME}.zip
	https://lostartefacts.dev/aux/tr2x/trgm.zip -> ${PN}-${TR2EXP_NAME}.zip
"
if [[ ${PV} = 9999 ]]; then
	EGIT_REPO_URI="https://github.com/LostArtefacts/TRX"
	EGIT_BRANCH="develop"

	inherit git-r3
else
	SRC_URI+="
		https://github.com/LostArtefacts/TRX/archive/refs/tags/trx-${PV}.tar.gz	-> ${P}.tar.gz
"
	S="${WORKDIR}/TRX-trx-${PV}"

	KEYWORDS="~amd64"
fi

inherit lua-single meson python-r1

LICENSE="GPL-3"
SLOT="0"
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
BDEPEND="app-arch/unzip"

pkg_setup() {
	lua-single_pkg_setup
}

if [[ ${PV} = 9999 ]]; then

src_unpack() {
	unpack ${PN}-data-${TRXDATA_COMMIT}.tar.gz

	mkdir -p "${WORKDIR}/"{${TR1EXP_NAME},${TR2EXP_NAME}} || die "mkdir failed"

	unpack ${PN}-${TR1EXP_NAME}.zip
	mv "${WORKDIR}/data" "${WORKDIR}/${TR1EXP_NAME}/" || die "mv 1 failed"

	unpack ${PN}-${TR2EXP_NAME}.zip
	mv "${WORKDIR}/data" "${WORKDIR}/${TR2EXP_NAME}/" || die "mv 2 failed"

	git-r3_src_unpack
}

fi

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

	# install only the executable binary and doc
	meson_src_install

	# II - Install Image
	local -r II="/usr/share/${PN}"
	local -r TRXDATA_S="${WORKDIR}/${PN}-data-${TRXDATA_COMMIT}"

	insinto "${II}"
	doins -r "${S}/data/trx/ship/cfg"
	doins -r "${S}/data/trx/ship/games"

	# TRX-data
	for game in tr1 tr1-ub tr2 tr2-gm tr3;
	do
		insinto "${II}/games/${game}"
		doins -r "${TRXDATA_S}/${game/-}/ship/data/images"
	done

	# expansions
	insinto "${II}/games/tr1-ub/levels"
	doins "${WORKDIR}/${TR1EXP_NAME}/data/"*.phd

	insinto "${II}/games/tr2-gm/levels"
	doins "${WORKDIR}/${TR2EXP_NAME}/data/"*.tr2
	doins "${WORKDIR}/${TR2EXP_NAME}/data/main_gm.sfx"
}

pkg_postinst() {
	elog "TRX files are installed into /usr/share/${PN}."
	elog "Original games files must still be installed into games/ subdirectory."
	elog "See https://github.com/LostArtefacts/TRX/blob/develop/docs/trx/INSTALLING.md"
}
