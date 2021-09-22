# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGIT_REPO_URI="https://github.com/libusb/hidapi"

CMAKE_ECLASS=cmake

inherit cmake-multilib git-r3

DESCRIPTION="A multi-platform library for USB and Bluetooth HID-Class devices"
HOMEPAGE="https://github.com/libusb/hidapi"

LICENSE="|| ( BSD GPL-3 HIDAPI )"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~ppc ~ppc64 ~x86"
IUSE="doc"

DEPEND=""
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
"

multilib_src_compile() {
	cmake_src_compile

	if multilib_is_native_abi && use doc; then
		doxygen "${S}"/doxygen/Doxyfile || die
	fi
}

multilib_src_install() {
	cmake_src_install

	if multilib_is_native_abi && use doc; then
		docinto html
		dodoc -r html/.
	fi
}
