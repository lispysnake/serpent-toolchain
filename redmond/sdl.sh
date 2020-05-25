#!/usr/bin/env -S -i bash --norc --noprofile
set -e

. $(dirname $(realpath -s $0))/common.sh

# Set up environment to build SDL
SDL_ROOT_DIR="${SERPENT_ROOT_DIR}/external/SDL"
SDL_BUILD_DIR="${SERPENT_BUILD_DIR}/SDL"

# Stage the root build directory
rm -rf "${SDL_BUILD_DIR}"
install -D -d -m 00755 "${SDL_BUILD_DIR}"

clean_external "SDL"

echo "Building SDL"
pushd "${SDL_BUILD_DIR}"
"${SDL_ROOT_DIR}/configure" \
    --prefix=/ \
    --with-sysroot="${SERPENT_DEPLOY_DIR}" \
    --host=x86_64-w64-mingw32

make -j${SERPENT_BUILD_JOBS}
make -j${SERPENT_BUILD_JOBS} install DESTDIR="${SERPENT_DEPLOY_DIR}"
