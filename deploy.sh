#!/bin/bash
set -euf -o pipefail

# Rebuild
stack exec site rebuild

# Create deploy environment inside of .deploy directory
mkdir .deploy
cd .deploy
git init
git remote add origin https://github.com/timokratia/timokratia.github.io.git
git pull -r origin master

# Add built site files
rsync -a ../_site/ .
git add .
git commit -m "$1"
git push origin master

# Cleanup .deploy directory after a successful push
cd ..
rm -rf .deploy

# # Build new files
# stack exec site clean
# stack exec site build

# # Get previous files
# git fetch --all
# git checkout -b master --track origin/master

# # Overwrite existing files with new files
# cp -a _site/. .

# # Commit
# git add -A
# git commit -m "Publish."

# # Push
# git push origin master:master

# # Restoration
# git checkout develop
# git branch -D master
# git stash pop
