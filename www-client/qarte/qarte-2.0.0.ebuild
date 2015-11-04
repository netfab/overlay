# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7} )

inherit eutils python-r1

DESCRIPTION="Qarte is a recorder for Arte+7 and Arte Live Web"
HOMEPAGE="https://launchpad.net/qarte"
SRC_URI=""

LICENSE="GPL-3"
SLOT="0"

inherit bzr
EBZR_REPO_URI="lp:qarte"

if [[ ${PV} = 9999 ]]; then
	KEYWORDS=""
else
	# revision - version
	# 143 - 2.0.0
	EBZR_REVISION="143"
	KEYWORDS="~amd64"
fi

IUSE=""

LANGS="de fr pt"
for X in ${LANGS} ; do
	IUSE="${IUSE} +linguas_${X}"
done

DEPEND=""
RDEPEND="${DEPEND}
	${PYTHON_DEPS}
	dev-python/notify-python
	>=dev-python/PyQt4-4.4
	dev-python/sip
	>=media-video/rtmpdump-2.3"

src_install() {
	cd "${S}"
	insinto "/usr/share/${PN}"
	doins *.py
	doins -r commonwidgets crontab medias VWidgets

	dodoc README
	doman qarte.1
	doicon qarte.png
	domenu q_arte.desktop
	exeinto /usr/bin/
	doexe qarte

	strip-linguas ${LANGS}
	MOPREFIX=${PN}

	local x
	for x in $LINGUAS; do
		msgfmt -c -o i18n/${x}.mo i18n/${x}.po
		domo i18n/${x}.mo
	done
}
