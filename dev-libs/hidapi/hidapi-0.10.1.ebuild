# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools multilib-minimal

DESCRIPTION="A multi-platform library for USB and Bluetooth HID-Class devices"
HOMEPAGE="https://github.com/libusb/hidapi"
SRC_URI="https://github.com/libusb/${PN}/archive/${P}.tar.gz"

LICENSE="|| ( BSD GPL-3 HIDAPI )"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~ppc ~ppc64 ~x86"
IUSE="doc fox static-libs"

DEPEND="fox? ( x11-libs/fox:= )"
RDEPEND="${DEPEND}
	virtual/libudev:0[${MULTILIB_USEDEP}]
	virtual/libusb:1[${MULTILIB_USEDEP}]
"
BDEPEND="
	doc? ( app-doc/doxygen )
	virtual/pkgconfig"

S="${WORKDIR}/${PN}-${P}"

src_prepare() {
	default

	# Fix build with autoconf 2.70
	# https://github.com/libusb/hidapi/commit/d15d594
	sed -i '16d' configure.ac || die

	# Fix bashisms in the configure.ac file.
	sed -i -e 's:\([A-Z_]\+\)+="\(.*\)":\1="${\1}\2":g' \
		-e 's:\([A-Z_]\+\)+=`\(.*\)`:\1="${\1}\2":g' configure.ac || die

	# Portage handles license texts itself, no need to install them
	sed -i -e 's/LICENSE.*/ # blank/' Makefile.am || die

	eautoreconf

	multilib_copy_sources
}

multilib_src_configure() {
	econf \
		$(multilib_native_use_enable fox testgui) \
		--enable-shared \
		$(use_enable static-libs static)
}

src_compile() {
	multilib-minimal_src_compile

	if use doc; then
		doxygen doxygen/Doxyfile || die
	fi
}

src_install() {
	multilib-minimal_src_install
	find "${D}" -name '*.la' -delete || die

	if use doc; then
		docinto html
		dodoc -r html/.
	fi
}
