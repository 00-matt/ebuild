# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 python3_{5..7} )
PYTHON_REQ_USE="threads(+)"

inherit distutils-r1
inherit waf-utils

DESCRIPTION="Library for writing text-based user interfaces"
HOMEPAGE="https://github.com/nsf/termbox"
SRC_URI="https://github.com/nsf/${PN}/archive/v${PV}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE="examples python static-libs"

RDEPEND="python? ( ${PYTHON_DEPS} )"
DEPEND="${PYTHON_DEPS}"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

pkg_setup() {
    python_setup
}

src_prepare() {      
    default
    
    sed -e '/append.*CFLAGS/ s|-O[0-0]||' \
	-i -- wscript
    
    if ! use examples
    then
	sed -e '/bld.recurse("demo")/d' \
	    -i -- src/wscript
    fi

    use python && distutils-r1_src_prepare
}

src_configure() {
    waf-utils_src_configure
    use python && distutils-r1_src_configure
}

src_compile() {
    waf-utils_src_compile
    use python && distutils-r1_src_compile
}

src_install() {
    local -a waf_cmd=(
	"${WAF_BINARY}"
	--destdir="${D}"
	--targets=$(usex static-libs 'termbox_static,' '')termbox_shared
	install
    )
    "${waf_cmd[@]}" || die

    use python && distutils-r1_src_install

    einstalldocs

    docinto tools
    dodoc tools/*.py

    if use examples
    then
	docinto demo
	dodoc src/demo/*.c
    fi
}
