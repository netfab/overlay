# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit cmake-utils
MY_PN="libwebcam"
MY_PV="0.2.5"
MY_P="${MY_PN}-src-${MY_PV}"

HOMEPAGE="http://sourceforge.net/projects/libwebcam/"
DESCRIPTION="Manage dynamic controls in uvcvideo"
SRC_URI="mirror://sourceforge/${MY_PN}/${MY_P}.tar.gz"

KEYWORDS="~amd64 ~x86"
SLOT="0"
LICENSE="GPL-3"
IUSE="static-libs"

DEPEND="dev-libs/libxml2"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_PN}-${MY_PV}"

src_install() {
	cmake-utils_src_install
	use static-libs || rm -fr "${D}"usr/lib*/${MY_PN}.a
}
