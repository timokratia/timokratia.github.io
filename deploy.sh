#!/bin/bash
set -euf -o pipefail

# Rebuild site
zola build

# Create deploy environment inside of .deploy directory
mkdir .deploy
cd .deploy
git init
git remote add origin https://github.com/timokratia/timokratia.github.io.git
git pull -r origin master

# Add built site files
rsync -a ../public/ .
git add .
git commit -m "$1"
git push origin master

# Cleanup .deploy directory after a successful push
cd ..
rm -rf .deploy