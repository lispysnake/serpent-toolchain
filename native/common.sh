# Tightly control the path
export PATH="/usr/bin:/bin/:/sbin:/usr/sbin"

SCRIPT_PATH="$(dirname $(realpath -s $0))"
TOP_DIR=`dirname "${SCRIPT_PATH}"`
export SERPENT_BUILD_DIR="${TOP_DIR}/build_native"
export HOME="${SERPENT_BUILD_DIR}"
export SERPENT_ROOT_DIR="${TOP_DIR}"

unset SCRIPT_PATH
unset TOP_DIR

