#!/bin/sh

REPOSITORY_PATH="https://${GITHUB_ACCESS_TOKEN}@github.com/$GITHUB_PAGES_REPO_AUTHOR/$GITHUB_PAGES_REPO_NAME.git"

echo "Checkout the publish repo"
git clone $REPOSITORY_PATH

echo "Add compiled files"
cp -R docs/* $GITHUB_PAGES_REPO_NAME

echo "Push the changes"
cd $GITHUB_PAGES_REPO_NAME
git add .
git commit -m "Published at $(date)"
git push

echo "Publishing complete"
