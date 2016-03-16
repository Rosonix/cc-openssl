#!/bin/bash

set -e

ROOT_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
TOOLCHAIN="${ROOT_DIR}/../mipsel-toolchain"
ROOTFS="${ROOT_DIR}/../rootfs"
OUT_DIR="${ROOTFS}/usr"

export CROSS_COMPILE=mipsel-linux-
export PATH="${TOOLCHAIN}/bin:${PATH}"

export CFLAGS=" -Os -W -Wall"
export CPPFLAGS=" -I${ROOTFS}/include -I${ROOTFS}/usr/include"
export LDFLAGS=" -L${ROOTFS}/lib -L${ROOTFS}/usr/lib"

./Configure linux-mips32 shared zlib-dynamic --prefix="${OUT_DIR}"
sed -i'' 's/\-gcc/gcc/' Makefile
make
make install
