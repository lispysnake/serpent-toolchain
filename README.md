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
