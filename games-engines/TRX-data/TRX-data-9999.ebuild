# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/LostArtefacts/TRX-data"

inherit git-r3

DESCRIPTION="Large binary assets for TRX"
HOMEPAGE="https://github.com/LostArtefacts/TRX-data"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""

src_install() {
	for game in tr1 tr2;
	do
		insinto /usr/share/TRX/${game}
		doins -r "${S}"/${game}/ship/.
	done
}
