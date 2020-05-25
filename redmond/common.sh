# Tightly control the path
export PATH="/usr/bin:/bin/:/sbin:/usr/sbin"

SCRIPT_PATH="$(dirname $(realpath -s $0))"
TOP_DIR=`dirname "${SCRIPT_PATH}"`
export SERPENT_BUILD_DIR="${TOP_DIR}/build_redmond"
export SERPENT_ROOT_DIR="${TOP_DIR}"
export SERPENT_BUILD_JOBS=$(nproc)
export SERPENT_DEPLOY_DIR="${TOP_DIR}/deploy_redmond"
export SERPENT_STAGING_DIR="${TOP_DIR}/staging_redmond"
export SERPENT_DOWNLOAD_DIR="${TOP_DIR}/downloads"

unset SCRIPT_PATH
unset TOP_DIR

# Merge path for already deployed bits
if [[ -e "${SERPENT_DEPLOY_DIR}/bin" ]]; then
    export PATH="${SERPENT_DEPLOY_DIR}/bin:${PATH}"
fi

function fetch_tarball()
{
    local pkgFile="${SERPENT_ROOT_DIR}/external/${1}"
    local url="$(cat ${pkgFile} | cut -d ' ' -f 1)"
    local sha="$(cat ${pkgFile} | cut -d ' ' -f 2)"
    local tarball=$(basename "${url}")

    if [[ ! -d "${SERPENT_DOWNLOAD_DIR}" ]]; then
        install -d -D -m 00755 "${SERPENT_DOWNLOAD_DIR}"
    fi
    local tarballTarget="${SERPENT_DOWNLOAD_DIR}/${tarball}"

    if [[ ! -e "${tarballTarget}" ]]; then
        echo "Downloading: ${tarball}"
        curl -L --output "${tarballTarget}" "${url}"
    fi

    echo "Computing SHA256SUM: ${tarball}"
    local dloadSha=$(sha256sum "${tarballTarget}" | cut -d ' ' -f 1)
    if [[ "${dloadSha}" != "${sha}" ]]; then
        echo "Invalid SHA256sum for ${tarballTarget}"
        exit 1
    fi
    echo "SHA256SUM verification passed."
}

function extract_tarball()
{
    local pkgFile="${SERPENT_ROOT_DIR}/external/${1}"
    local url="$(cat ${pkgFile} | cut -d ' ' -f 1)"
    local tarball=$(basename "${url}")
    local stageBall="${SERPENT_DOWNLOAD_DIR}/${tarball}"

    local tgtDir="${SERPENT_STAGING_DIR}/${1}"
    echo "Extracting ${1}"
    rm -rf "${SERPENT_STAGING_DIR}/${1}"
    install -D -d -m 00755 "${SERPENT_STAGING_DIR}/${1}"
    tar xf "${stageBall}" --strip-components=1 -C  "${tgtDir}"
}
