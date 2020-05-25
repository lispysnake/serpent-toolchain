
#!/usr/bin/env -S -i bash --norc --noprofile
set -e

. $(dirname $(realpath -s $0))/common.sh

# Set up environment to build SDL
PKGCONF_ROOT_DIR="${SERPENT_ROOT_DIR}/external/pkgconf"
PKGCONF_BUILD_DIR="${SERPENT_BUILD_DIR}/pkgconf"

# Stage the root build directory
rm -rf "${PKGCONF_BUILD_DIR}"
install -D -d -m 00755 "${PKGCONF_BUILD_DIR}"

clean_external "pkgconf"

echo "Building pkgconf"
pushd "${PKGCONF_ROOT_DIR}"
autoreconf -vfi
popd

pushd "${PKGCONF_BUILD_DIR}"
"${PKGCONF_ROOT_DIR}/configure" \
    --prefix=/ \
    --with-sysroot="${SERPENT_DEPLOY_DIR}" \
    --target=x86_64-w64-mingw32 \
    --with-system-includedir="${SERPENT_DEPLOY_DIR}/include" \
    --with-system-libdir="${SERPENT_DEPLOY_DIR}/lib" \
    --disable-shared \
    --enable-static

make -j${SERPENT_BUILD_JOBS}
make -j${SERPENT_BUILD_JOBS} install DESTDIR="${SERPENT_DEPLOY_DIR}"
ln -sv pkgconf "${SERPENT_DEPLOY_DIR}/bin/pkg-config"
