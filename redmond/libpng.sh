
#!/usr/bin/env -S -i bash --norc --noprofile
set -e

. $(dirname $(realpath -s $0))/common.sh

# Set up environment to build SDL
LIBPNG_ROOT_DIR="${SERPENT_ROOT_DIR}/external/libpng"
LIBPNG_BUILD_DIR="${SERPENT_BUILD_DIR}/libpng"

# Stage the root build directory
rm -rf "${LIBPNG_BUILD_DIR}"
install -D -d -m 00755 "${LIBPNG_BUILD_DIR}"

clean_external "libpng"

echo "Building libpng"

pushd "${LIBPNG_BUILD_DIR}"

"${LIBPNG_ROOT_DIR}/configure" \
    --prefix="${SERPENT_DEPLOY_DIR}" \
    --exec-prefix="${SERPENT_DEPLOY_DIR}" \
    --host=x86_64-w64-mingw32 \
    --enable-shared \
    --enable-static \
    --libdir="${SERPENT_DEPLOY_DIR}/lib" \
    --includedir="${SERPENT_DEPLOY_DIR}/include" \
    --bindir="${SERPENT_DEPLOY_DIR}/bin"

make -j${SERPENT_BUILD_JOBS}
make -j${SERPENT_BUILD_JOBS} install
