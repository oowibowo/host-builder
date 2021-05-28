#!/bin/bash
set -x

CDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
REPOS=${CDIR}/../repos

git -C ${REPOS} clone https://github.com/sedillo/linuxbox.git build-kernel 
