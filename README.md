### serpent-toolchain

This repository (will) contain a collection of scripts that help to build
the toolchain required for the Serpent Game Framework.

Specifically, it is (to be) used to assist in cross-compilation **from Linux**
to various build targets.

In order to ensure all Serpent developers are on the same level of support,
we target explicit LDC/Dlang/etc versions.

Requirements

 - ld.gold (binutils-gold)
 - Working host toolchain (gcc/g++)
 - Working build tools (cmake/autotools)
 - Working host ldc (> 0.17)
 - bash
 - Linux host
 - Patience
 - ccache

Eventual goals:

Automate the build and cross-compiler steps to produce a full SDK toolchain
located at `/opt/serpent/toolchain` which can either be packaged up or provided
in a flatpak or similar.

We must provide at least the native option, plus cross-compilation for Windows
and Android.

We'll also merge much of serpent-support into this repository and kill serpent-support,
instead requiring serpent-toolchain is present to **build** serpent applications,
knowing that all required libraries and such are present.

macOS may come later.

TODO:

 - Fix flags to optimise toolchain to maximum possible
 - Ensure fPIC, etc, for relocatable builds
 - Integrate CVE checking / patching
 - Set correct flags/etc/ for each package (png support, etc.)
