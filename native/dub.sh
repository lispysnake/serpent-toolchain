#!/usr/bin/env -S -i bash --norc --noprofile
set -e

. $(dirname $(realpath -s $0))/common.sh

LDC_BINARY="${SERPENT_DEPLOY_DIR}/bin/ldc2"

if [[ ! -x "${LDC_BINARY}" ]]; then
    echo "${LDC_BINARY} not found. Run native/ldc.sh first"
    exit 1
fi
