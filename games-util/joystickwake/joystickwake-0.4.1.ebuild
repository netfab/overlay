# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..11} )

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

# dbus-next and python-xlib are not mandatory (just recommended),
# but should we introduce useflag for this ?
RDEPEND="
	dev-python/dbus-next[${PYTHON_USEDEP}]
	dev-python/python-xlib[${PYTHON_USEDEP}]
	dev-python/pyudev[${PYTHON_USEDEP}]
"

DOCS=( LICENSE README.rst )
