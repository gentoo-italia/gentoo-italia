# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

CRATES="
encoding-0.2.33
ignore-0.3.1
log-0.4.1
rayon-0.9.0
regex-0.2.6
clap-2.24.2
datetime-0.4.7
env_logger-0.5.0
hex-0.3.1
serde-1.0.27
serde_derive-1.0.27
serde_cbor-0.8.2
serde_json-1.0.10
serde_yaml-0.7.3
toml-0.4.5
lazy_static-1.0.0
tempdir-0.3.6
handlebars-0.29.1
ansi_term-0.9.0
atty-0.2.2
bitflags-0.8.0
strsim-0.6.0
term_size-0.3.0
unicode-segmentation-1.0.1
unicode-width-0.1.4
vec_map-0.8.0
encoding-index-japanese-1.20141219.5
encoding-index-korean-1.20141219.5
encoding-index-simpchinese-1.20141219.5
encoding-index-singlebyte-1.20141219.5
encoding-index-tradchinese-1.20141219.5
libc-0.2.37
kernel32-sys-0.2.2
winapi-0.2.8
chrono-0.4.0
termcolor-0.3.5
num-0.1.42
time-0.1.36
winapi-build-0.1.1
num-integer-0.1.36
num-iter-0.1.35
num-traits-0.2.0
crossbeam-0.2.12
globset-0.2.1
lazy_static-0.2.11
log-0.3.9
memchr-2.0.1
same-file-1.0.2
thread_local-0.3.2
walkdir-2.1.4
cfg-if-0.1.2
encoding_index_tests-0.1.4
either-1.0.3
rayon-core-1.3.0
aho-corasick-0.6.0
fnv-1.0.6
coco-0.1.1
num_cpus-1.2.1
rand-0.3.22
memchr-1.0.2
scopeguard-0.3.3
regex-syntax-0.4.1
utf8-ranges-1.0.0
redox_syscall-0.1.37
rand-0.4.2
fuchsia-zircon-0.3.2
byteorder-1.0.0
wincolor-0.1.6
winapi-0.3.4
winapi-i686-pc-windows-gnu-0.4.0
winapi-x86_64-pc-windows-gnu-0.4.0
quote-0.3.8
serde_derive_internals-0.19.0
syn-0.11.11
unreachable-0.1.1
thread-id-3.0.0
dtoa-0.4.2
itoa-0.3.4
void-1.0.2
linked-hash-map-0.5.1
num-traits-0.1.37
yaml-rust-0.4.0
synom-0.11.3
unicode-xid-0.0.4
remove_dir_all-0.3.0
pest-0.3.0
quick-error-1.0.0
bitflags-1.0.0
fuchsia-zircon-sys-0.3.2
tokei-${PV}
"

inherit bash-completion-r1 cargo

DESCRIPTION="A program that allows you to count your code, quickly."
HOMEPAGE="https://github.com/Aaronepower/tokei"
SRC_URI="$(cargo_crate_uris ${CRATES})"

LICENSE="MIT/Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RESTRICT="mirror"
DEPEND=">=virtual/rust-1.17"
RDEPEND="${DEPEND}"

src_install() {
	cargo_src_install
}
