# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit git-r3

DESCRIPTION="Create X11 pointer barriers around your working area"
HOMEPAGE="https://www.uninformativ.de/git/xpointerbarrier/file/README.html"
EGIT_REPO_URI="https://www.uninformativ.de/git/xpointerbarrier.git"

LICENSE="MIT"
SLOT="0"

RDEPEND="x11-libs/libX11
		 x11-libs/libXfixes
		 x11-libs/libXrandr
		 ${DEPEND}"

src_install() {
	emake prefix=/usr DESTDIR="${D}" install
}
