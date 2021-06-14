#!/bin/bash

REPO_NAME=build-kernel
REPO_DIR=${HB_REPO}/${REPO_NAME}

#Build Kernel
git -C ${HB_REPO} clone -b 2-chrome-os https://github.com/sedillo/linuxbox.git ${REPO_NAME} 
cd ${REPO_DIR}

docker build -t linux_box:latest -f ./dockerfiles/Dockerfile.kernel ./dockerfiles
docker run \
    -v ${REPO_DIR}/build:/build \
    -v ${REPO_DIR}/src:/src \
    -v ${REPO_DIR}/build.sh:/build.sh \
    -it --rm \
    linux_box:latest /build.sh

#Stage Kernel
cp build/linux-headers*.deb /opt/stage/kernel/linux-headers.deb
cp build/linux-image*.deb /opt/stage/kernel/linux-image.deb

#Download ovmf
cd ${HB_REPO} 
mkdir -p ovmf
cd ${HB_REPO}/ovmf
apt-get install -y alien

#TODO Script getting latest or building
#wget https://www.kraxel.org/repos/jenkins/edk2/edk2.git-ovmf-x64-0-20210421.12.gf297b7f200.noarch.rpm
wget https://www.kraxel.org/repos/jenkins/edk2/edk2.git-ovmf-x64-0-20210421.18.g15ee7b7689.noarch.rpm

#Stage ovmf
alien edk2.git-ovmf*.rpm
cp edk2.git-ovmf-*.deb /opt/stage/kernel/OVMF.deb

