# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python{3_4,3_5,3_6} )
PYTHON_REQ_USE="sqlite"

inherit eutils distutils-r1

MY_CHAN="devel"
MY_PV="${PV}dev"
MY_P="${P}dev"

DESCRIPTION="PyQt5 launcher for FS-UAE"
HOMEPAGE="https://fs-uae.net/"
SRC_URI="https://fs-uae.net/fs-uae/${MY_CHAN}/${MY_PV}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="|| ( dev-python/PyQt5[${PYTHON_USEDEP}]
			 dev-python/pyside[${PYTHON_USEDEP}] )
		dev-python/python-lhafile[${PYTHON_USEDEP}]
		dev-python/requests[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}
	app-emulation/fs-uae"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	default
	# Remove bundled requests package
	sed -i '/"requests": "."/d' setup.py || die "sed failure"
	distutils-r1_src_prepare
}

src_compile() {
	distutils-r1_src_compile
	emake mo
}

python_install() {
	cd "${S}" || die
	distutils-r1_python_install --install-lib="${ROOT}usr/share/${PN}"
	emake prefix="${ROOT}usr" DESTDIR="${D}" install
}
