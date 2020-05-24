# Tightly control the path
export PATH="/usr/bin:/bin/:/sbin:/usr/sbin"

SCRIPT_PATH="$(dirname $(realpath -s $0))"
TOP_DIR=`dirname "${SCRIPT_PATH}"`
export SERPENT_BUILD_DIR="${TOP_DIR}/build_native"
export HOME="${SERPENT_BUILD_DIR}"
export SERPENT_ROOT_DIR="${TOP_DIR}"
export SERPENT_BUILD_JOBS=$(nproc)
export SERPENT_DEPLOY_DIR="${TOP_DIR}/deploy_native"

unset SCRIPT_PATH
unset TOP_DIR

export CC="gcc"
export CXX="g++"

# ccache breaks ldmd, so manually force it
if [[ -e "/usr/lib64/ccache/bin" ]]; then
    export PATH="/usr/lib64/ccache/bin:$PATH"
elif [[ -e "/usr/lib/ccache/bin" ]]; then
    export PATH="/usr/lib/ccache/bin:$PATH"
fi

export CFLAGS="-mtune=generic -march=x86-64 -g2 -O2 -pipe -fPIC -D_FORTIFY_SOURCE=2 -fstack-protector-strong -Wformat -Wall -Wno-error -Wp,-D_REENTRANT"
export CXXFLAGS="-mtune=generic -march=x86-64 -g2 -O2 -pipe -fPIC -D_FORTIFY_SOURCE=2 -fstack-protector-strong -Wall -Wno-error -Wp,-D_REENTRANT"

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
