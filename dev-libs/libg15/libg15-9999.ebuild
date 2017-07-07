# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

EGIT_REPO_URI="https://github.com/netfab/libg15"
EGIT_BRANCH="dev"

inherit autotools git-r3 multilib-minimal

DESCRIPTION="Library for Logitech G15 Gaming Keyboard and similar devices features"
HOMEPAGE="https://github.com/netfab/libg15"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="virtual/libusb:0[${MULTILIB_USEDEP}]"
DEPEND="${RDEPEND}"

src_prepare() {
	default
	eautoreconf
}

multilib_src_configure() {
	ECONF_SOURCE="${S}" econf
}

