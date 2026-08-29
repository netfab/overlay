# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/netfab/xfwaita"
EGIT_BRANCH="meson_build_system"

PYTHON_COMPAT=( python3_{8..14} )

inherit git-r3 meson python-r1

DESCRIPTION="Adwaita Theme (GNOME 3) for Xfwm4"
HOMEPAGE="https://github.com/netfab/xfwaita"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

DEPEND="${PYTHON_DEPS}"
RDEPEND="${DEPEND}"
BDEPEND="
	${PYTHON_DEPS}
	dev-python/pillow
	media-gfx/imagemagick
"
