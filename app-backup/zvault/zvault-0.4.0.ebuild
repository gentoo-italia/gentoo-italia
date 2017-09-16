# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

CRATES="
aho-corasick-0.6.3
ansi_term-0.9.0
atty-0.2.2
bitflags-0.7.0
bitflags-0.9.1
blake2-rfc-0.2.17
byteorder-1.1.0
chrono-0.4.0
clap-2.25.0
constant_time_eq-0.1.2
crossbeam-0.2.10
filetime-0.1.10
fuse-0.3.0
kernel32-sys-0.2.2
lazy_static-0.2.8
libc-0.1.12
libc-0.2.26
libsodium-sys-0.0.15
linked-hash-map-0.3.0
linked-hash-map-0.4.2
log-0.3.8
memchr-1.0.1
mmap-0.1.1
murmurhash3-0.0.5
num-0.1.40
num-integer-0.1.35
num-iter-0.1.34
num-traits-0.1.40
pbr-1.0.0
pkg-config-0.3.9
quick-error-1.2.0
rand-0.3.15
redox_syscall-0.1.26
regex-0.2.2
regex-syntax-0.4.1
rmp-0.8.6
rmp-serde-0.13.4
serde-1.0.10
serde_bytes-0.10.1
serde_utils-0.6.0
serde_yaml-0.7.1
sodiumoxide-0.0.15
squash-sys-0.9.0
strsim-0.6.0
tar-0.4.13
tempdir-0.3.5
term_size-0.3.0
textwrap-0.6.0
thread-scoped-1.0.2
thread_local-0.3.4
time-0.1.38
unicode-segmentation-1.1.0
unicode-width-0.1.4
unreachable-1.0.0
users-0.5.2
utf8-ranges-1.0.0
vec_map-0.8.0
void-1.0.2
winapi-0.2.8
winapi-build-0.1.1
xattr-0.1.11
xattr-0.2.0
yaml-rust-0.3.5
"

inherit cargo

DESCRIPTION="A highly efficient deduplicating backup solution"
HOMEPAGE="https://github.com/dswd/zvault"
SRC_URI="https://github.com/dswd/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
	$(cargo_crate_uris ${CRATES})"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="man"

RDEPEND=">=app-arch/squash-0.8.0_pre20170601
	dev-libs/libsodium
	sys-fs/fuse:0"
DEPEND="${RDEPEND}
	man? ( app-text/ronn )"

RESTRICT="mirror"

src_compile() {
	export CARGO_HOME="${ECARGO_HOME}"

	cargo build -v \
		$(usex debug "" --release) \
		|| die "cargo build failed"

	if use man; then
		ln -s ../deb/${PN}/Makefile docs/ || die
		emake -C docs/ build
	fi
}

src_install() {
	dobin target/release/${PN}

	newdoc docs/man/${PN}.1.md ${PN}.md

	if use man; then
		doman docs/man/*.1
	fi
}
