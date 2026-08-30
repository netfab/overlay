# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/netfab/xfwaita"
EGIT_BRANCH="meson_build_system"

PYTHON_COMPAT=( python3_{12..14} )

inherit git-r3 meson python-any-r1

DESCRIPTION="Adwaita Theme (GNOME 3) for Xfwm4"
HOMEPAGE="https://github.com/netfab/xfwaita"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""

BDEPEND="
	${PYTHON_DEPS}
	dev-python/pillow
	media-gfx/imagemagick
"
