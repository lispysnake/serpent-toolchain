#!/usr/bin/env -S -i bash --norc --noprofile
set -e

. $(dirname $(realpath -s $0))/common.sh

# Set up environment to build SDL
SDL_IMAGE_ROOT_DIR="${SERPENT_ROOT_DIR}/external/SDL_image"
SDL_IMAGE_BUILD_DIR="${SERPENT_BUILD_DIR}/SDL_image"

# Stage the root build directory
rm -rf "${SDL_IMAGE_BUILD_DIR}"
install -D -d -m 00755 "${SDL_IMAGE_BUILD_DIR}"

clean_external "SDL_image"

echo "Building SDL_image"
pushd "${SDL_IMAGE_ROOT_DIR}"
./autogen.sh
popd

pushd "${SDL_IMAGE_BUILD_DIR}"
"${SDL_IMAGE_ROOT_DIR}/configure" \
    --prefix=/ \
    --with-sysroot="${SERPENT_DEPLOY_DIR}" \
    --host=x86_64-w64-mingw32 \
    --with-sdl-prefix="${SERPENT_DEPLOY_DIR}" \
    --enable-shared \
    --enable-static \
    --disable-sdltest

make -j${SERPENT_BUILD_JOBS}
# make -j${SERPENT_BUILD_JOBS} install DESTDIR="${SERPENT_DEPLOY_DIR}"
