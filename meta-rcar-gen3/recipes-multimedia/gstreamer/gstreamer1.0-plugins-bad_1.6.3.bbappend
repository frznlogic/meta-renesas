SRC_URI = "git://github.com/renesas-rcar/gst-plugins-bad.git;branch=RCAR-GEN3/1.6.3"
SRC_URI += " \
    file://configure-allow-to-disable-libssh2.patch \
    file://0001-glimagesink-Downrank-to-marginal.patch \
    file://0002-glplugin-glwindow-fix-memory-leak-of-navigation-thre.patch \
"
SRCREV = "9b7c647fb89c137439c2edae5e96c44c8fe6337f"

DEPENDS += "weston wayland-native"

S = "${WORKDIR}/git"

# submodule is extracted before do_populate_lic
addtask do_init_submodule after do_unpack before do_patch

do_init_submodule() {
    export http_proxy=${http_proxy}
    export https_proxy=${https_proxy}
    export HTTP_PROXY=${HTTP_PROXY}
    export HTTPS_PROXY=${HTTPS_PROXY}
    cd ${S}
    git submodule init
    git submodule update
}

do_configure_prepend() {
    cd ${S}
    ./autogen.sh --noconfigure
    cd ${B}
}

RDEPENDS_${PN} = "libwayland-egl"
