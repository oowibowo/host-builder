#!/bin/bash
set -x

CDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
REPOS=${CDIR}/../repos

git -C ${REPOS} clone https://github.com/sedillo/kvm-automation  
cp ${REPOS}/kvm-automation/scripts/run-tpm.sh /opt/stage/kvm-target/var/vm/scripts/
chmod +x /opt/stage/kvm-target/var/vm/scripts/run-tpm.sh

