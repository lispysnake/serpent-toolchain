#!/usr/bin/env -S -i bash --norc --noprofile
set -e

. $(dirname $(realpath -s $0))/common.sh

export BINUTILS_ROOT_DIR="${SERPENT_STAGING_DIR}/binutils"
export BINUTILS_BUILD_DIR="${SERPENT_BUILD_DIR}/binutils"

# Stage the root build directory
rm -rf "${BINUTILS_BUILD_DIR}"
install -D -d -m 00755 "${BINUTILS_BUILD_DIR}"

fetch_tarball binutils
extract_tarball binutils

pushd "${BINUTILS_BUILD_DIR}"
echo "Building binutils"
"${BINUTILS_ROOT_DIR}/configure" \
    --prefix=/ \
    --with-sysroot="${SERPENT_DEPLOY_DIR}" \
    --target=x86_64-w64-mingw32 \
    --enable-targets=x86_64-w64-mingw32,i686-w64-mingw32 \
    --disable-nls

make -j${SERPENT_BUILD_JOBS}

echo "Installing binutils"
make -j${SERPENT_BUILD_JOBS} DESTDIR="${SERPENT_DEPLOY_DIR}" install
