#!/bin/sh

REPOSITORY_PATH="https://${PUBLISHING_GIT_TOKEN}@github.com/$GITHUB_PAGES_REPO_AUTHOR/$GITHUB_PAGES_REPO_NAME.git"

echo "Checkout the publish repo"
git clone $REPOSITORY_PATH

echo "Add compiled files"
cp -R docs/* $GITHUB_PAGES_REPO_NAME

cd $GITHUB_PAGES_REPO_NAME

# this is only required while developing, when the site is hosted below the root
# of the relevant domain (in my case, at https://digitalronin.github.io/cpug-publish)
echo "Hack for non-root publishing"
find . -name '*.html' | xargs sed -i '' 's/stylesheets.manifest.css/$(PUBLISH_REPO)\/stylesheets\/manifest.css/'; \
find . -name '*.html' | xargs sed -i '' 's/javascripts.application.js/$(PUBLISH_REPO)\/javascripts\/application.js/'; \
find . -name '*.html' | xargs sed -i '' 's/assets/$(PUBLISH_REPO)\/assets/'; \
find . -name '*.html' | xargs sed -i '' 's/"\/images/"\/$(PUBLISH_REPO)\/images/'; \
find . -name '*.css' | xargs sed -i '' 's/"\/images/"\/$(PUBLISH_REPO)\/images/'; \
find . -name '*.css' | xargs sed -i '' 's/assets/$(PUBLISH_REPO)\/assets/'; \
find . -name '*.js' | xargs sed -i '' 's/"\/search.json/"\/$(PUBLISH_REPO)\/search.json/'; \

echo "Push the changes"
git config --global user.email "foo@bar.com"
git config --global user.name "Foo Bar"
git add .
git commit -m "Published at $(date)"
git push

echo "Publishing complete"
