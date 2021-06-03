#!/bin/bash
set -x

CDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
REPOS=${CDIR}/../repos

git -C ${REPOS} clone https://github.com/sedillo/linuxbox.git build-kernel 
cd ${REPOS}/build-kernel
docker build -t linux_box:latest -f ./dockerfiles/Dockerfile.kernel ./dockerfiles
docker run \
    -v ${PWD}/build:/build \
    -v ${PWD}/src:/src \
    -v ${PWD}/build.sh:/build.sh \
    -it --rm \
    linux_box:latest /build.sh

cp build/linux-headers*.deb /opt/stage/kernel/linux-headers.deb
cp build/linux-image*.deb /opt/stage/kernel/linux-image.deb

cd ${REPOS} 
mkdir -p ovmf
cd ${REPOS}/ovmf
apt-get install -y alien

#TODO Script getting latest or building
#wget https://www.kraxel.org/repos/jenkins/edk2/edk2.git-ovmf-x64-0-20210421.12.gf297b7f200.noarch.rpm
wget https://www.kraxel.org/repos/jenkins/edk2/edk2.git-ovmf-x64-0-20210421.18.g15ee7b7689.noarch.rpm

alien edk2.git-ovmf*.rpm
cp edk2.git-ovmf-*.deb /opt/stage/kernel/OVMF.deb

