#!/usr/bin/env -S -i bash --norc --noprofile
set -e

. $(dirname $(realpath -s $0))/common.sh

# Set up environment to build ZLIB
ZLIB_ROOT_DIR="${SERPENT_ROOT_DIR}/external/zlib"

# Stage the root build directory
clean_external "zlib"

echo "Building ZLIB"
pushd "${ZLIB_ROOT_DIR}"

# TODO Consider NOT relying on AVX-specific build.
export CFLAGS="${CFLAGS} -msse4.1 -mavx2 -march=x86-64 -mtune=generic"
make PREFIX="x86_64-w64-mingw32-" -j${SERPENT_BUILD_JOBS} -f "win32/Makefile.gcc" SHARED_MODE=1 CFLAGS="${CFLAGS}"
make PREFIX="x86_64-w64-mingw32-" -j${SERPENT_BUILD_JOBS} -f "win32/Makefile.gcc" SHARED_MODE=1 CFLAGS="${CFLAGS}" install LIBRARY_PATH="${SERPENT_DEPLOY_DIR}/lib"  INCLUDE_PATH="${SERPENT_DEPLOY_DIR}/include" BINARY_PATH="${SERPENT_DEPLOY_DIR}/bin"
