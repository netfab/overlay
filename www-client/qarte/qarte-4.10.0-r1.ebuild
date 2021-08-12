# Copyright 1999-2021 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python{3_6,3_7,3_8,3_9} )

PLOCALES="de fr pt"

if [[ ${PV} = 9999 ]]; then
	EBZR_REPO_URI="lp:qarte"
	# bzr eclass removed
	# https://bugs.gentoo.org/719892
	inherit bzr
	KEYWORDS=""
	SRC_URI=""
	DEPEND="sys-devel/gettext"
else
	KEYWORDS="~amd64 ~x86"
	SRC_URI="https://www.oqapy.eu/releases/${P}.tar.gz"
	DEPEND=""
fi

inherit desktop plocale python-r1

DESCRIPTION="Qarte is a recorder for Arte+7 and Arte Live Web"
HOMEPAGE="https://launchpad.net/qarte"

LICENSE="GPL-3"
SLOT="0"

IUSE=""

RDEPEND="${DEPEND}
	${PYTHON_DEPS}
	dev-python/PyQt5[multimedia,svg]
	dev-python/sip
	dev-qt/qttranslations
	>=media-video/rtmpdump-2.3
	virtual/cron"

src_prepare() {
	default

	if [[ ${PV} = 9999 ]]; then
		plocale_find_changes "${S}/i18n" "" ".po"
	else
		plocale_find_changes "${S}/locale" "" ""
	fi
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
		if [[ ${PV} = 9999 ]]; then
			msguniq --use-first i18n/${1}.po > i18n/${1}-uniq.po
			msgfmt -c -o i18n/${1}.mo i18n/${1}-uniq.po
			domo i18n/${1}.mo
		else
			local modir="locale/${1}/LC_MESSAGES"
			cp "${modir}/${PN}.mo" "${modir}/${1}.mo"
			domo "${modir}/${1}.mo"
		fi
	}

	plocale_for_each_locale install_locale
}
