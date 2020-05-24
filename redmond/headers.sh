#!/usr/bin/env -S -i bash --norc --noprofile
set -e

. $(dirname $(realpath -s $0))/common.sh

export HEADERS_ROOT_DIR="${SERPENT_STAGING_DIR}/mingw-w64"
export HEADERS_BUILD_DIR="${SERPENT_BUILD_DIR}/mingw-w64-headers"

# Stage the root build directory
rm -rf "${HEADERS_BUILD_DIR}"
install -D -d -m 00755 "${HEADERS_BUILD_DIR}"

fetch_tarball mingw-w64
extract_tarball mingw-w64

pushd "${HEADERS_BUILD_DIR}"
echo "Building mingw-w64-headers"
"${HEADERS_ROOT_DIR}/mingw-w64-headers/configure" \
    --prefix=/x86_64-w64-mingw32 \
    --with-sysroot="${SERPENT_DEPLOY_DIR}" \
    --host=x86_64-w64-mingw32

make -j${SERPENT_BUILD_JOBS}

echo "Installing mingw-w64-headers"
make -j${SERPENT_BUILD_JOBS} DESTDIR="${SERPENT_DEPLOY_DIR}" install
ln -sv "x86_64-w64-mingw32" "${SERPENT_DEPLOY_DIR}/mingw"
ln -sv "lib" "${SERPENT_DEPLOY_DIR}/x86_64-w64-mingw32/lib64"
