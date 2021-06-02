# host-builder

Host Builder for ESP GVTg KVM cobination

This is being done as sudo since ESP requires it

## Download/configure host-builder
```bash
sudo su
cd /opt
git clone https://github.com/sedillo/host-builder.git
/opt/host-builder/scripts/configure.sh
```
## Install Docker
```bash
/opt/host-builder/scripts/install-docker.sh
```

## Install ESP
```bash
/opt/host-builder/scripts/install-esp.sh
```

## Build Kernel & OVMF
This step take about 30 minutes
```bash
/opt/host-builder/scripts/build-kernel.sh
```
## Configure host with built kernel
TBD

## Choose a Target VM System
Create a VM file system based on one of the existing branches and fill in <BRANCH>:
- 2-chrome-os
- chrome-os
- 2-ubuntu-desktop
- ubuntu-desktop
 
```bash
git -C /opt/stage clone -b <BRANCH> https://github.com/sedillo/kvm-target.git target
```

## Disk Images
Move any disk images to the following directory *Make sure the file ends in .qcow2*
- /opt/stage/disk/\*.qcow2

## Optional: Qemu Binary
A default Qemu is installed by default, but this can be overriden by adding qemu here 
- /opt/stage/qemu/qemu.tar.gz
