#!/bin/bash
set -x

CDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
REPOS=${CDIR}/../repos

git -C ${REPOS} clone https://github.com/sedillo/configure-ubuntu.git 
${REPOS}/configure-ubuntu/scripts/install-docker.sh
