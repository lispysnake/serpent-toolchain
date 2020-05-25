#!/usr/bin/env -S -i bash --norc --noprofile
set -e

. $(dirname $(realpath -s $0))/common.sh

export CRT_ROOT_DIR="${SERPENT_STAGING_DIR}/mingw-w64"
export CRT_BUILD_DIR="${SERPENT_BUILD_DIR}/mingw-w64-crt"

# Stage the root build directory
rm -rf "${CRT_BUILD_DIR}"
install -D -d -m 00755 "${CRT_BUILD_DIR}"

fetch_tarball mingw-w64
extract_tarball mingw-w64

pushd "${CRT_BUILD_DIR}"
echo "Building mingw-w64-crt"

zsh "${CRT_ROOT_DIR}/mingw-w64-crt/configure" \
    --prefix=/x86_64-w64-mingw32 \
    --with-sysroot="${SERPENT_DEPLOY_DIR}" \
    --host=x86_64-w64-mingw32 \
    --enable-lib32 \
    --enable-lib64

make -j${SERPENT_BUILD_JOBS}

echo "Installing mingw-w64-crt"
make -j${SERPENT_BUILD_JOBS} DESTDIR="${SERPENT_DEPLOY_DIR}" install
