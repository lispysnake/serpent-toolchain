# Tightly control the path
export PATH="/usr/bin:/bin/:/sbin:/usr/sbin"

SCRIPT_PATH="$(dirname $(realpath -s $0))"
TOP_DIR=`dirname "${SCRIPT_PATH}"`
export SERPENT_BUILD_DIR="${TOP_DIR}/build_native"
export HOME="${SERPENT_BUILD_DIR}"
export SERPENT_ROOT_DIR="${TOP_DIR}"

unset SCRIPT_PATH
unset TOP_DIR

# Purge and restage the external directory
function clean_external()
{
    local externDir="${SERPENT_ROOT_DIR}/external/${1}"
    if [[ ! -d "${externDir}" ]]; then
        echo "${externDir}: Missing."
        exit 1
    fi
    rm -rf "${externDir}"
    echo "Restaging external/${1}"
    git -C "${SERPENT_ROOT_DIR}" submodule update --init --recursive "external/${1}"
}
