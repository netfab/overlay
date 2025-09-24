# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Small bash functions library"
HOMEPAGE="https://framagit.org/netfab/libfunc"

if [[ ${PV} == "9999" ]]; then
	EGIT_REPO_URI="https://framagit.org/netfab/libfunc.git"
	inherit git-r3
fi

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""

src_install() {
	insinto /usr/lib/libfunc
	doins core.sh core_ansi.sh core_command.sh core_exit.sh core_getopts.sh core_msg.sh
}
