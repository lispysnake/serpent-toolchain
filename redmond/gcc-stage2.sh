#!/usr/bin/env -S -i bash --norc --noprofile
set -e

. $(dirname $(realpath -s $0))/common.sh

export GCC_ROOT_DIR="${SERPENT_STAGING_DIR}/gcc"
export GCC_BUILD_DIR="${SERPENT_BUILD_DIR}/gcc-stage2"

# Stage the root build directory
rm -rf "${GCC_BUILD_DIR}"
install -D -d -m 00755 "${GCC_BUILD_DIR}"

fetch_tarball gcc
fetch_tarball mpfr
fetch_tarball gmp
fetch_tarball mpc

extract_tarball gcc
extract_tarball mpfr
extract_tarball gmp
extract_tarball mpc

echo "Building gcc-stage2"
pushd "${GCC_BUILD_DIR}"

ln -s "${SERPENT_STAGING_DIR}/mpfr" .
ln -s "${SERPENT_STAGING_DIR}/mpc" .
ln -s "${SERPENT_STAGING_DIR}/gmp" .

"${GCC_ROOT_DIR}/configure" \
    --prefix=/ \
    --with-sysroot="${SERPENT_DEPLOY_DIR}" \
    --target=x86_64-w64-mingw32 \
    --enable-targets=all \
    --disable-nls \
    --with-multilib-list=m32,m64 \
    --enable-multilib \
    --enable-shared \
    --enable-static \
    --enable-languages=c,c++

make -j${SERPENT_BUILD_JOBS}

echo "Installing gcc-stage2"
make -j${SERPENT_BUILD_JOBS} DESTDIR="${SERPENT_DEPLOY_DIR}"
