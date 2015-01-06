# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python3_4 )

inherit distutils-r1 git-2

EGIT_REPO_URI="git://github.com/foresto/joystickwake.git"
EGIT_COMMIT="e55e11f9c0afb5f9d5836d878287944948efc3dc"

DESCRIPTION="A joystick-aware screen waker"
HOMEPAGE="https://github.com/foresto/joystickwake"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="dev-python/pyudev[${PYTHON_USEDEP}]"

DOCS=( LICENSE README.rst )
