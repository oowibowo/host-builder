#!/bin/bash


SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
BUILDER_DIR="${SCRIPT_DIR/\/scripts/}"
REPO_DIR="${BUILDER_DIR}/repos"
TEMPLATE_DIR="${BUILDER_DIR}/templates"
