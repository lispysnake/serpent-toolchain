#!/usr/bin/env -S -i bash --norc --noprofile

. $(dirname $(realpath -s $0))/common.sh

# Set up environment to build LDC
LDC_BUILD_DIR="${SERPENT_BUILD_DIR}/ldc"
LDC_ROOT_DIR="${SERPENT_ROOT_DIR}/external/ldc"

# Stage the root build directory
rm -rf "${LDC_BUILD_DIR}"
install -D -d -m 00755 "${LDC_BUILD_DIR}"

clean_external "ldc"
