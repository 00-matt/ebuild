# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake-utils

DESCRIPTION="RandomX, CryptoNight and Argon2 CPU miner"
HOMEPAGE="https://xmrig.com https://github.com/xmrig/xmrig"
SRC_URI="https://github.com/xmrig/xmrig/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+asm +hwloc ssl"

PATCHES=(
    "${FILESDIR}/${PN}-fix-name.patch"
)

DEPEND="
	dev-libs/libuv
	hwloc? ( sys-apps/hwloc )
	ssl? ( dev-libs/openssl )"
RDEPEND="${DEPEND}"

src_configure() {
    local mycmakeargs=(
	-DWITH_ASM=$(usex asm)
	-DWITH_HTTP=OFF
	-DWITH_HWLOC=$(usex hwloc)
	-DWITH_LIBCPUID=OFF
	-DWITH_TLS=$(usex ssl)
    )
    
    # TODO: Use flag for HTTP API. Will require a patch to use system
    #       net-libs/http-parser library instead of bundled src.
    # TODO: Use flags for PoW algos (e.g. cn-lite, cn-heavy)

    cmake-utils_src_configure
}

src_compile() {
    cmake-utils_src_compile
}

src_install() {
    dobin "${BUILD_DIR}/xmrig"
    dodoc README.md doc/ALGORITHMS.md doc/API.md doc/CPU.md
}

pkg_postinst() {
    ewarn "To get maximum performance, enable huge pages with the"
    ewarn "vm.nr_hugepages parameter."
}
