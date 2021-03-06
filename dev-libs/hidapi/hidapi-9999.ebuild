# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGIT_REPO_URI="https://github.com/libusb/hidapi"

inherit autotools git-r3 multilib-minimal

DESCRIPTION="A multi-platform library for USB and Bluetooth HID-Class devices"
HOMEPAGE="https://github.com/libusb/hidapi"

LICENSE="|| ( BSD GPL-3 HIDAPI )"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~ppc ~ppc64 ~x86"
IUSE="doc fox static-libs"

DEPEND="fox? ( x11-libs/fox:= )"
RDEPEND="${DEPEND}
	kernel_linux? (
		virtual/libudev:0[${MULTILIB_USEDEP}]
		virtual/libusb:1[${MULTILIB_USEDEP}]
	)
	kernel_FreeBSD? (
		virtual/libusb:1[${MULTILIB_USEDEP}]
	)
"
BDEPEND="
	doc? ( app-doc/doxygen )
	virtual/pkgconfig"

src_prepare() {
	default

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
