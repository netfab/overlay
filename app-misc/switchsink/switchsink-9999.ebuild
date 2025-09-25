# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="command line utility to switch process audio sink"
HOMEPAGE="https://framagit.org/netfab/switchsink/"

if [[ ${PV} == "9999" ]]; then
	EGIT_REPO_URI="https://framagit.org/netfab/switchsink.git"
	inherit git-r3
fi

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""

RDEPEND="dev-libs/libfunc"

src_install() {
	dobin switchsink
}
