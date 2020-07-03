BUILD_DIR := "cpug-publish"

build:
	middleman build --build-dir ../$(BUILD_DIR)/
	make hack-non-root-site

# this is only required while developing, when the site is hosted below the root
# of the relevant domain (in my case, at https://digitalronin.github.io/cpug-publish)
hack-non-root-site:
	( \
	  cd ../$(BUILD_DIR); \
		touch .nojekyll; \
		find * -name '*.html' | xargs sed -i '' 's/stylesheets.manifest.css/$(BUILD_DIR)\/stylesheets\/manifest.css/'; \
		find * -name '*.html' | xargs sed -i '' 's/javascripts.application.js/$(BUILD_DIR)\/javascripts\/application.js/'; \
		find * -name '*.html' | xargs sed -i '' 's/assets/$(BUILD_DIR)\/assets/'; \
		find * -name '*.html' | xargs sed -i '' 's/"\/images/"\/$(BUILD_DIR)\/images/'; \
		find * -name '*.css' | xargs sed -i '' 's/"\/images/"\/$(BUILD_DIR)\/images/'; \
		find * -name '*.css' | xargs sed -i '' 's/assets/$(BUILD_DIR)\/assets/'; \
		find * -name '*.js' | xargs sed -i '' 's/"\/search.json/"\/$(BUILD_DIR)\/search.json/'; \
	)
