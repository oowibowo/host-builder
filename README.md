# host-builder

Host Builder for ESP GVTg KVM cobination

This is being done as sudo since ESP requires it

## Download/configure host-builder
```bash
sudo su
cd /opt
git clone https://github.com/sedillo/host-builder.git
```

## Setup environment
The following command will set up the variables below for ease of use in the following scripts
- $HB_SCRIPT
- $HB_HOME
- $HB_REPO
- $HB_TEMPLATE

```
source /opt/host-builder/scripts/env.sh
$HB_SCRIPT/configure.sh
```

## Install Docker
```bash 
$HB_SCRIPT/install-docker.sh
```

## Install ESP
This will setup a directory /opt/stage that points to the ESP Apache server. This will allow ESP builds to grab our KVM, GVTg, and VM files.
```bash
$HB_SCRIPT/install-esp.sh
```

## Build Kernel & OVMF
This step take about 30 minutes
```bash
$HB_SCRIPT/build-kernel.sh
```

## Choose a Target VM System
Create a VM file system based on one of the existing branches and fill in BRANCH variable
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

## BETA: Configure the host with all the previous files to test the current setup
This is beta because it is not guaranteed to work if host and target are different.
```bash
#Install missing libraries
apt-get install -y wget qemu-system-x86 ovmf libegl1-mesa-dev

#Install kernel 
dpkg -i $HB_REPO/build-kernel/build/

#Fetch helper scripts
git -C $HB_REPO clone https://github.com/sedillo/idv.git

#Configure grub and initramfs
$HB_REPO/idv/scripts/config-grub.sh
$HB_REPO/idv/scripts/config-modules.sh

#Move qcow files to test
mkdir -p /var/vm/disk
mv *.qcow /var/vm/disk

#Move idv files
cp -r /opt/stage/target/* /
source /var/vm/scripts/env.sh

#Setup IDV
$IDV_SCRIPT/create-vgpu.sh
$IDV_SCRIPT/start-vm.sh

#Reboot to apply changes
reboot
```
 
## Optional: Qemu Binary
A default Qemu is installed by default, but this can be overriden by adding qemu here 
- /opt/stage/qemu/qemu.tar.gz
