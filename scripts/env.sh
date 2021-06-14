#!/bin/bash


export HB_SCRIPT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
export HB_HOME="${HB_SCRIPT/\/scripts/}"
export HB_TEMPLATE="${HB_HOME}/templates"

export HB_REPO="${HB_HOME}/repos"
mkdir -p ${HB_REPO}
