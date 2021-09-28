# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python{3_6,3_7,3_8,3_9} )

if [[ ${PV} = "9999" ]]; then
	EGIT_REPO_URI="https://github.com/foresto/joystickwake.git"
	inherit git-r3
else
	RESTRICT="mirror"
	SRC_URI="https://github.com/foresto/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
fi

inherit distutils-r1

DESCRIPTION="A joystick-aware screen waker"
HOMEPAGE="https://github.com/foresto/joystickwake"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="dev-python/pyudev[${PYTHON_USEDEP}]"

DOCS=( LICENSE README.rst )
