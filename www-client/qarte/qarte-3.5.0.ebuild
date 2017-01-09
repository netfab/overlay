# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6
PYTHON_COMPAT=( python2_7 )

PLOCALES="de fr pt"

EBZR_REPO_URI="lp:qarte"

if [[ ${PV} = 9999 ]]; then
	KEYWORDS=""
else
	# revision - version
	# 143 - 2.0.0
	# 158 - 3.5.0
	EBZR_REVISION="158"
	KEYWORDS="~amd64"
fi

inherit bzr l10n python-r1

DESCRIPTION="Qarte is a recorder for Arte+7 and Arte Live Web"
HOMEPAGE="https://launchpad.net/qarte"
SRC_URI=""

LICENSE="GPL-3"
SLOT="0"

IUSE=""

DEPEND="sys-devel/gettext"
RDEPEND="${DEPEND}
	${PYTHON_DEPS}
	dev-python/notify-python
	dev-python/PyQt5
	dev-python/sip
	>=media-video/rtmpdump-2.3"

src_prepare() {
	default

	l10n_find_plocales_changes "${S}/i18n" "" ".po"
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

	MOPREFIX=${PN}

	install_locale() {
		msguniq --use-first i18n/${1}.po > i18n/${1}-uniq.po
		msgfmt -c -o i18n/${1}.mo i18n/${1}-uniq.po
		domo i18n/${1}.mo
	}

	l10n_for_each_locale_do install_locale
}
