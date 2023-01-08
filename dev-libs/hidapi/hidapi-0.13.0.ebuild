# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

if [[ ${PV} == "9999" ]]; then
	EGIT_REPO_URI="https://github.com/libusb/hidapi"
	inherit git-r3
else
	SRC_URI="https://github.com/libusb/${PN}/archive/${P}.tar.gz"
	S="${WORKDIR}/${PN}-${P}"
	KEYWORDS="~amd64 ~arm ~arm64 ~ppc ~ppc64 ~x86"
fi

CMAKE_ECLASS=cmake

inherit cmake-multilib

DESCRIPTION="A multi-platform library for USB and Bluetooth HID-Class devices"
HOMEPAGE="https://github.com/libusb/hidapi"

LICENSE="|| ( BSD GPL-3 HIDAPI )"
SLOT="0"
IUSE="doc"

DEPEND="
	virtual/libudev:0[${MULTILIB_USEDEP}]
	virtual/libusb:1[${MULTILIB_USEDEP}]
"
RDEPEND="${DEPEND}"
BDEPEND="
	doc? ( app-doc/doxygen )
"

multilib_src_compile() {
	cmake_src_compile

	if use doc && multilib_is_native_abi; then
		local doxyfile="${S}/doxygen/Doxyfile"
		# INPUT     fix sources directory
		# RECURSIVE generate also API documentation
		sed -i \
			-e 's/^INPUT .*/INPUT=..\/'${PN}'-'${P}'/g' \
			-e 's/^RECURSIVE .*/RECURSIVE=YES/g' \
			${doxyfile} || die "Sed broke!"
		doxygen ${doxyfile} || die
	fi
}

multilib_src_install() {
	cmake_src_install

	if use doc && multilib_is_native_abi; then
		local HTML_DOCS=( html/. )
	fi
	einstalldocs
}
