#!/bin/sh
set -eu
cd "$(dirname "$0")"
echo "Entering directory '$PWD'"
set -x
wget -O languages.yml https://raw.githubusercontent.com/github/linguist/master/lib/linguist/languages.yml
