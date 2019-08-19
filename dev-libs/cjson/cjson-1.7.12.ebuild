# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake-utils

DESCRIPTION="Ultralightweight JSON parser in ANSI C"
HOMEPAGE="https://github.com/DaveGamble/cJSON"
SRC_URI="https://github.com/DaveGamble/${PN}/archive/v${PV}.tar.gz"
S="${WORKDIR}/cJSON-${PV}" # different capitalisation to default

LICENSE="MIT"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE="static-libs"

src_configure() {
    if use static-libs
    then
	mycmakeargs="-DBUILD_SHARED_AND_STATIC_LIBS=On"
    fi

    cmake-utils_src_configure
}

src_compile() {
    cmake-utils_src_compile
}

src_install() {
    cmake-utils_src_install
}
