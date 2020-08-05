# Copyright 1999-2020 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python{3_6,3_7,3_8,3_9} )

inherit distutils-r1

RESTRICT="mirror"

SRC_URI="https://github.com/foresto/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

DESCRIPTION="A joystick-aware screen waker"
HOMEPAGE="https://github.com/foresto/joystickwake"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="dev-python/pyudev[${PYTHON_USEDEP}]"

DOCS=( LICENSE README.rst )
