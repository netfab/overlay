# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python{3_3,3_4,3_5} )
PYTHON_REQ_USE="sqlite"

inherit eutils distutils-r1

DESCRIPTION="PyQt4 launcher for FS-UAE"
HOMEPAGE="https://fs-uae.net/"
SRC_URI="https://fs-uae.net/fs-uae/devel/${PV}dev/${P}dev.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="|| ( dev-python/PyQt5[${PYTHON_USEDEP}]
	dev-python/pyside[${PYTHON_USEDEP}] )
	dev-python/pygame[${PYTHON_USEDEP}]
	dev-python/python-lhafile[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}
	app-emulation/fs-uae"

S="${WORKDIR}/${P}dev"

src_prepare() {
	# Remove bundled requests package
	sed -i '/"requests": "."/d' setup.py || die "sed failure"
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
