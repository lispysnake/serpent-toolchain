#!/usr/bin/env -S -i bash --norc --noprofile
set -e

. $(dirname $(realpath -s $0))/common.sh

LDC_BINARY="${SERPENT_DEPLOY_DIR}/bin/ldmd2"

if [[ ! -x "${LDC_BINARY}" ]]; then
    echo "${LDC_BINARY} not found. Run native/ldc.sh first"
    exit 1
fi

# Set up environment to build LDC
DUB_ROOT_DIR="${SERPENT_ROOT_DIR}/external/dub"
DUB_NATIVE_DIR="${SERPENT_BUILD_DIR}/dub-native"

# Stage the root build directory
rm -rf "${DUB_NATIVE_DIR}"
install -D -d -m 00755 "${DUB_NATIVE_DIR}"

clean_external "dub"

echo "Building dub"
pushd "${DUB_ROOT_DIR}"

export LDC="${LDC_BINARY}"
export DMD="${LDC_BINARY}"

"${LDC_BINARY}" --run build.d
mv bin/dub "${SERPENT_DEPLOY_DIR}/bin/dub"
