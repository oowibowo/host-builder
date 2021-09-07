#!/bin/bash
set -x

CDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
REPOS=${CDIR}/../repos
TEMPLATES=${CDIR}/../templates


# Automating step 3 from:
# https://github.com/intel/edge-software-provisioner#quick-installation-guide
git -C /opt clone -b v2.0 --depth=1 https://github.com/intel/Edge-Software-Provisioner.git esp


# Copying prebuilt config.yml file
cp ${CDIR}/../templates/config.yml /opt/esp/conf/config.yml


# Automating step 4-5 from:
# https://github.com/intel/edge-software-provisioner#quick-installation-guide
cd /opt/esp
./build.sh
./run.sh -n

# Create a staging folder
cd /opt
mkdir -p /opt/esp/data/usr/share/nginx/html/stage
ln -s /opt/esp/data/usr/share/nginx/html/stage stage

# Sub-staging folders
mkdir -p /opt/stage/kernel
mkdir -p /opt/stage/qemu
mkdir -p /opt/stage/disk

