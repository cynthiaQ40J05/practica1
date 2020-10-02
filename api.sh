#!/usr/bin/env bash
set -euo pipefail

API_USR=$1
API_PASS=$2
GIT_USR=$3
GIT_REPO=$4
curl "https://api.github.com/users/$GIT_USR/repos"
curl "https://api.github.com/gitignore/templates"
