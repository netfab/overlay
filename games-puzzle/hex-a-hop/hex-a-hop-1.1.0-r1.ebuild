# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools

DESCRIPTION="a hexagonal tile-based puzzle game"
HOMEPAGE="http://hexahop.sourceforge.net/"
SRC_URI="mirror://sourceforge/hexahop/${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug nls +sound +truetype"

RDEPEND="media-libs/libsdl
	nls? ( sys-devel/gettext )
	sound? ( media-libs/sdl-mixer[vorbis] )
	!truetype? ( media-libs/sdl-pango )
	truetype? ( media-libs/sdl-ttf )"
DEPEND="${RDEPEND}"

src_prepare() {
	default

	# fix build system (ideally should be committed upstream)
	sed -i \
		-e 's/debug=no/debug=$enableval/' \
		-e 's/sound=no/sound=$enableval/' \
		-e 's/ttf=no/ttf=$enableval/' \
		-e 's/relative=yes/relative=$enableval/' \
		configure.ac || die "sed failure"

	mkdir msc/m4 || die "mkdir failure"
	eautoreconf
}

src_configure() {
	econf \
		--disable-relpath \
		$(use_enable debug) \
		$(use_enable sound) \
		$(use_enable truetype sdlttf)
}

src_install() {
	emake DESTDIR="${D}" install

	if ! use sound; then
		einfo "removing ogg files"
		rm -f "${D}/usr/share/${PN}"/*.ogg || die "rm failure"
	fi

	doicon "${FILESDIR}"/${PN}.xpm
	make_desktop_entry ${PN} Hex-a-Hop
}
