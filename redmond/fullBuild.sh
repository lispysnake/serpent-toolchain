#!/usr/bin/env bash

echo "Preparing initial toolchain"

$(dirname $(realpath -s $0))/binutils.sh
$(dirname $(realpath -s $0))/headers.sh
$(dirname $(realpath -s $0))/gcc-stage1.sh
$(dirname $(realpath -s $0))/crt.sh
$(dirname $(realpath -s $0))/gcc-stage2.sh
$(dirname $(realpath -s $0))/mingw64.sh

echo "Preparing tools"
$(dirname $(realpath -s $0))/pkgconf.sh


echo "Preparing runtime support"
$(dirname $(realpath -s $0))/zlib.sh
$(dirname $(realpath -s $0))/libpng.sh

echo "Preparing SDL"
$(dirname $(realpath -s $0))/sdl.sh
$(dirname $(realpath -s $0))/sdl_image.sh
$(dirname $(realpath -s $0))/sdl_mixer.sh
