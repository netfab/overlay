# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
inherit git-2 games

DESCRIPTION="The main game for the Minetest game engine"
HOMEPAGE="http://github.com/minetest/minetest_game"
EGIT_REPO_URI="git://github.com/netfab/${PN}.git"
EGIT_BRANCH="i18n_support"

LICENSE="GPL-2 CC-BY-SA-3.0"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="~games-action/minetest-${PV}"

src_unpack() {
	git-2_src_unpack
}

src_install() {
	insinto "${GAMES_DATADIR}"/minetest/games/${PN}
	doins -r mods menu
	doins game.conf minetest.conf

	# builds mo files
	local x pofile filepath
	local modpath="${D}/${GAMES_DATADIR}"/minetest/games/${PN}/mods/
	for x in $(find "${modpath}" -mindepth 4 -name '*.po'); do
		pofile=${x##*/}
		pofile=${pofile:0:0-3}
		filepath=${x%/*}
		echo -n "${filepath}/${pofile}.po : "
		msgfmt "${filepath}/${pofile}.po" -cv -o "${filepath}/${pofile}.mo"
	done
	# delete po files
	find "${modpath}" -name '*.po' -delete

	dodoc README.txt game_api.txt

	prepgamesdirs
}
