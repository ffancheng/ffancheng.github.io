#!/usr/bin/env bash

# This script allows you to easily and quickly generate and deploy your website
# using Hugo to your personal GitHub Pages repository. This script requires a
# certain configuration. Run the `setup.sh` script to configure this. See
# https://hjdskes.github.io/blog/update-deploying-hugo-on-personal-github-pages/
# for more information.

# Set the English locale for the `date` command.
export LC_TIME=en_US.UTF-8

# The commit message.
# MESSAGE= "$(git log --pretty=format:"%s" -1)"

msg() {
    printf "\033[1;32m :: %s\n\033[0m" "$1"
}

# Check if there are any uncommitted changes.
if [[ $(git status -s) ]]; then
    msg "The working directory is dirty, please commit or stash any pending changes"
    exit 1;
fi

# Ensure the `public` directory is clean before building.
msg "Removing the old website (if exists)"
rm -rf public

# Build the website using Hugo.
msg "Building the website"
hugo

# Copy the CNAME file to the `public` directory if it exists.
msg "Copying CNAME"
cp CNAME public/

# Navigate to the `public` directory and initialize git.
msg "Pushing the updated \`public\` folder to the \`gh-pages\` branch"
pushd public
git init
git add .
git commit -m "Deploy Hugo site"
popd

# Push the changes to the `gh-pages` branch.
git subtree push --prefix public origin gh-pages

msg "Deployment complete!"
