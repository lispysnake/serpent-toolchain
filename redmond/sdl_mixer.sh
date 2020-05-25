#!/usr/bin/env -S -i bash --norc --noprofile
set -e

. $(dirname $(realpath -s $0))/common.sh

# TODO: Add ogg/vorbis /flac / mp3 / opusfile support

# Set up environment to build SDL
SDL_MIXER_ROOT_DIR="${SERPENT_ROOT_DIR}/external/SDL_mixer"
SDL_MIXER_BUILD_DIR="${SERPENT_BUILD_DIR}/SDL_mixer"

# Stage the root build directory
rm -rf "${SDL_MIXER_BUILD_DIR}"
install -D -d -m 00755 "${SDL_MIXER_BUILD_DIR}"

clean_external "SDL_mixer"

echo "Building SDL_mixer"
pushd "${SDL_MIXER_ROOT_DIR}"
./autogen.sh
popd

pushd "${SDL_MIXER_BUILD_DIR}"
"${SDL_MIXER_ROOT_DIR}/configure" \
    --prefix="${SERPENT_DEPLOY_DIR}" \
    --host=x86_64-w64-mingw32 \
    --with-sdl-prefix="${SERPENT_DEPLOY_DIR}" \
    --enable-shared \
    --enable-static \
    --disable-sdltest

make -j${SERPENT_BUILD_JOBS}
make -j${SERPENT_BUILD_JOBS} install
