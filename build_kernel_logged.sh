#!/bin/bash

set -e
set -o pipefail

export ARCH=arm
export CROSS_COMPILE=/home/username/android_kernel_samsung_msm8974/arm-linux-androideabi-4.9/bin/arm-linux-androideabi-

export KBUILD_BUILD_USER=SammyRomKernel
export KBUILD_BUILD_HOST=MondrianLTE

LOGFILE=build.log

mkdir -p output

echo "===> DEFCONFIG" | tee $LOGFILE
make -C $(pwd) O=output msm8974_sec_defconfig \
    VARIANT_DEFCONFIG=msm8974_sec_mondrianlte_eur_defconfig \
    SELINUX_DEFCONFIG=selinux_defconfig 2>&1 | tee -a $LOGFILE

echo "===> BUILD" | tee -a $LOGFILE
make -j64 -C $(pwd) O=output 2>&1 | tee -a $LOGFILE

echo "===> COPYING IMAGE" | tee -a $LOGFILE
cp output/arch/arm/boot/Image $(pwd)/arch/arm/boot/zImage
