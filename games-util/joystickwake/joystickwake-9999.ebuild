# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..14} )

MY_ROOT_URI="https://codeberg.org/forestix/${PN}"

if [[ "${PV}" == "9999" ]]; then
	EGIT_REPO_URI="${MY_ROOT_URI}"
	inherit git-r3
else
	RESTRICT="mirror"
	SRC_URI="${MY_ROOT_URI}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

inherit distutils-r1

DESCRIPTION="A joystick-aware screen waker"
HOMEPAGE="https://codeberg.org/forestix/joystickwake"

S="${WORKDIR}/${PN}"

LICENSE="MIT"
SLOT="0"

# dbus-next and python-xlib are not mandatory (just recommended)
RDEPEND="
	dev-python/dbus-next[${PYTHON_USEDEP}]
	dev-python/python-xlib[${PYTHON_USEDEP}]
	dev-python/pyudev[${PYTHON_USEDEP}]
"

DOCS=( LICENSE README.rst )
