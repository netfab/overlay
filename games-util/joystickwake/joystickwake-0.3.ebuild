# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..11} )

if [[ ${PV} == "9999" ]]; then
	EGIT_REPO_URI="https://github.com/foresto/joystickwake.git"
	inherit git-r3
else
	RESTRICT="mirror"
	SRC_URI="https://github.com/foresto/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

inherit distutils-r1

DESCRIPTION="A joystick-aware screen waker"
HOMEPAGE="https://github.com/foresto/joystickwake"

LICENSE="MIT"
SLOT="0"
IUSE=""

RDEPEND="dev-python/pyudev[${PYTHON_USEDEP}]"

DOCS=( LICENSE README.rst )
