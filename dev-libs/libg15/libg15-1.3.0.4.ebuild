# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

if [[ "${PV}" == "9999" ]]; then
	EGIT_REPO_URI="https://github.com/netfab/libg15"
	EGIT_BRANCH="dev"
	inherit git-r3
else
	SRC_URI="https://github.com/netfab/${PN}/archive/v.${PV}.tar.gz -> ${P}.tar.gz"
fi

inherit autotools multilib-minimal

DESCRIPTION="Library for Logitech G15 Gaming Keyboard and similar devices features"
HOMEPAGE="https://github.com/netfab/libg15"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="virtual/libusb:0[${MULTILIB_USEDEP}]"
DEPEND="${RDEPEND}"

DOCS=()

[[ ${PV} = 9999 ]] || S=${WORKDIR}/${PN}-v.${PV}

src_prepare() {
	default
	eautoreconf
}

multilib_src_configure() {
	ECONF_SOURCE="${S}" econf
}

