#!/usr/bin/env -S -i bash --norc --noprofile
set -e

. $(dirname $(realpath -s $0))/common.sh

# Set up environment to build LDC
LDC_BUILD_DIR="${SERPENT_BUILD_DIR}/ldc"
LDC_ROOT_DIR="${SERPENT_ROOT_DIR}/external/ldc"
LDC_BOOTSTRAP_DIR="${SERPENT_BUILD_DIR}/ldc-bootstrap"

# Stage the root build directory
rm -rf "${LDC_BUILD_DIR}"
rm -rf "${LDC_BOOTSTRAP_DIR}"
install -D -d -m 00755 "${LDC_BUILD_DIR}"
install -D -d -m 00755 "${LDC_BOOTSTRAP_DIR}"

clean_external "ldc"

echo "Bootstrapping LDC"
pushd "${LDC_BOOTSTRAP_DIR}"
cmake -GNinja "${LDC_ROOT_DIR}" \
    -DCMAKE_BUILD_TYPE=Release \
    -DBUILD_SHARED_LIBS=OFF \
    -DD_COMPILER_ID="ldc2" \
    -DCMAKE_INSTALL_PREFIX="${LDC_BOOTSTRAP_DIR}/install" \
    -DLDC_DYNAMIC_COMPILE=OFF

ninja -j${SERPENT_BUILD_JOBS}
ninja -j${SERPENT_BUILD_JOBS} install
