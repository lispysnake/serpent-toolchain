#!/usr/bin/env bash

$(dirname $(realpath -s $0))/binutils.sh
$(dirname $(realpath -s $0))/headers.sh
$(dirname $(realpath -s $0))/gcc-stage1.sh
$(dirname $(realpath -s $0))/crt.sh
$(dirname $(realpath -s $0))/gcc-stage2.sh
$(dirname $(realpath -s $0))/mingw64.sh
