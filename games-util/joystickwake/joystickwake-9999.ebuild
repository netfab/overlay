# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python{3_4,3_5} )

inherit distutils-r1 git-r3

EGIT_REPO_URI="git://github.com/foresto/joystickwake.git"

DESCRIPTION="A joystick-aware screen waker"
HOMEPAGE="https://github.com/foresto/joystickwake"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="dev-python/pyudev[${PYTHON_USEDEP}]"

DOCS=( LICENSE README.rst )
