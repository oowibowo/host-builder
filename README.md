# host-builder

Host Builder for ESP GVTg KVM cobination

This is being done as sudo since ESP requires it

## Download host-builder
```bash
sudo su
git -C /opt clone -b 2-chrome-os https://github.com/sedillo/host-builder.git
```

## Setup environment
The following command will set up the variables below for ease of use in the following scripts
- $HB_SCRIPT
- $HB_HOME
- $HB_REPO
- $HB_TEMPLATE

```
source /opt/host-builder/scripts/env.sh
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
Create a VM file system based that will go on ESP targets
```bash
git -C /opt/stage clone -b 2-chrome-os https://github.com/sedillo/kvm-target.git target
```

## Disk Images
Move the disk images to the following directory 
- /opt/stage/disk/vm1-chromeos.qcow2
- /opt/stage/disk/vm2-chromeos.qcow2

It's important to have two separate files here. During run time each VM needs it's own file system structure (\*.qcow2 file) that it can read/write to. 

It's ok to use the same qcow2 file twice if both VMs use the same image. But COPY the file so that each VM system has it's qcow2 file.

## Boot Targets into PXE
At this point the ESP server should be running and ready to build target machines, [review the documentation here](https://github.com/intel/Edge-Software-Provisioner/tree/v1.6.1). 

## BETA: Configure the host with all the previous files to test the current setup
This is a new feature and beta because it is not guaranteed to work especially if host and target are different.
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
