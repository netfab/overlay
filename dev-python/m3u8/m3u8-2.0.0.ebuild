# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python{3_9,3_10} )
inherit distutils-r1

DESCRIPTION="python m3u8 parser"
HOMEPAGE="
	https://pypi.org/project/m3u8/
"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-python/iso8601"
BDEPEND=""
