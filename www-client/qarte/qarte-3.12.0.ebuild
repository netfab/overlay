# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
PYTHON_COMPAT=( python{3_4,3_5,3_6} )

PLOCALES="de fr pt"

if [[ ${PV} = 9999 ]]; then
	EBZR_REPO_URI="lp:qarte"
	inherit bzr
	KEYWORDS=""
else
	KEYWORDS="~amd64 ~x86"
	SRC_URI="https://www.oqapy.eu/releases/${P}.tar.gz"
fi

inherit desktop l10n python-r1

DESCRIPTION="Qarte is a recorder for Arte+7 and Arte Live Web"
HOMEPAGE="https://launchpad.net/qarte"

LICENSE="GPL-3"
SLOT="0"

IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
	${PYTHON_DEPS}
	dev-python/notify-python
	dev-python/PyQt5
	dev-python/sip
	>=media-video/rtmpdump-2.3"

src_prepare() {
	default

	l10n_find_plocales_changes "${S}/locale" "" ""
}

src_install() {
	insinto "/usr/share/${PN}"
	doins *.py
	doins -r gui medias

	doman qarte.1
	doicon qarte.png
	domenu q_arte.desktop
	exeinto /usr/bin/
	doexe qarte

	local MOPREFIX=${PN}

	install_locale() {
		local modir="locale/${1}/LC_MESSAGES"
		cp "${modir}/${PN}.mo" "${modir}/${1}.mo"
		domo "${modir}/${1}.mo"
	}

	l10n_for_each_locale_do install_locale
}
