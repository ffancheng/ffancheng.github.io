#!/usr/bin/env bash

# This script allows you to easily and quickly generate and deploy your website
# using Hugo to your personal GitHub Pages repository. This script requires a
# certain configuration, run the `setup.sh` script to configure this. See
# https://hjdskes.github.io/blog/update-deploying-hugo-on-personal-github-pages/
# for more information.

# Set the English locale for the `date` command.
export LC_TIME=en_US.UTF-8

# The commit message.
# MESSAGE= "$(git log --pretty=format:"%s" -1)"

msg() {
    printf "\033[1;32m :: %s\n\033[0m" "$1"
}

if [[ $(git status -s) ]]; then
    msg "The working directory is dirty, please commit or stash any pending changes"
    exit 1;
fi

msg "Removing the old website"
pushd public
git rm -rf *
popd

msg "Building the website"
hugo

msg "Copying CNAME"
cp CNAME public/

msg "Pushing the updated \`public\` folder to the \`gh-pages\` branch"
pushd public
git add *
git commit
popd
git push origin gh-pages
