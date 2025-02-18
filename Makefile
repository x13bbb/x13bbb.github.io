# Makefile for GitHub Pages Jekyll blog

# Variables
JEKYLL := bundle exec jekyll

# Default target
all: build

# Install dependencies
install:
	bundle install

# Build the site
build:
	$(JEKYLL) build --verbose

# Serve the site locally
dev:
	$(JEKYLL) serve --port 4001 --livereload --incremental --watch

# Clean the built site
clean:
	rm -rf _site

# Build the site for production (you might want to set JEKYLL_ENV=production)
prod:
	JEKYLL_ENV=production $(JEKYLL) build

# Deploy to GitHub Pages (assuming you're using gh-pages branch)
deploy: prod
	git checkout live
	git merge main
	git push origin live
	git checkout main

# Run tests (if you have any)
test:
	# Add your test commands here, for example:
	# bundle exec rspec

# Check for broken links
check_links:
	$(JEKYLL) build
	$(JEKYLL) doctor

# Create a new post
new_post:
	@read -p "enter the title of the post: " title; \
	read -p "enter the description of the post: " desc; \
	read -p "enter categories (comma-separated): " categories; \
	date=$$(date +%Y-%m-%d); \
	slug=$$(echo "$$title" | sed -e 's/[^[:alnum:]]/-/g' | tr -s '-' | tr A-Z a-z); \
	filename="_posts/$$date-$$slug.md"; \
	echo "---" > "$$filename"; \
	echo "layout: post" >> "$$filename"; \
	echo "title: \"$$title\"" >> "$$filename"; \
	echo "date: $$date 00:00:00 +0000" >> "$$filename"; \
	echo "description: \"$$desc\"" >> "$$filename"; \
	echo "categories: [" >> "$$filename"; \
	IFS=',' read -ra CATEGORY_ARRAY <<< "$$categories"; \
	for category in "$${CATEGORY_ARRAY[@]}"; do \
		echo "  \"$$category\"," >> "$$filename"; \
	done; \
	sed -i '$$ s/,$//' "$$filename"; \
	echo "]" >> "$$filename"; \
	echo "---" >> "$$filename"; \
	echo "\nNew post created: $$filename"

# Create a lib entry
new_lib:
	@read -p "enter the title of the lib entry (page name): " title; \
	read -p "enter the title of the doc (with file ext): " doc; \
	read -p "enter the date of the lib entry (yyyy-mm-dd): " desc; \
	read -p "enter the remarks of the doc (with file ext): " remark; \
	read -p "enter categories (comma-separated): " categories; \
	read -p "enter the number of authors: " num_authors; \
	date=$$(date +%Y-%m-%d); \
	slug=$$(echo "$$title" | sed -e 's/[^[:alnum:]]/-/g' | tr -s '-' | tr A-Z a-z); \
	filename="_lib/$$slug.md"; \
	doc_title=$$(echo "$$doc" | sed 's/\.[^.]*$$//'); \
	echo "---" > "$$filename"; \
	echo "layout: pdf" >> "$$filename"; \
	echo "title: \"$$doc_title\"" >> "$$filename"; \
	echo "file: \"$$doc\"" >> "$$filename"; \
	echo "permalink: \"/lib/$$slug/\"" >> "$$filename"; \
	echo "date: $$desc" >> "$$filename"; \
	echo "remark: $$remark" >> "$$filename"; \
	echo "categories: [$$categories]" >> "$$filename"; \
	if [ "$$num_authors" -eq 1 ]; then \
		read -p "Enter the author's name: " author; \
		echo "author: \"$$author\"" >> "$$filename"; \
	else \
		echo "author:" >> "$$filename"; \
		for i in $$(seq 1 $$num_authors); do \
			read -p "Enter author $$i's name: " author; \
			echo "  - \"$$author\"" >> "$$filename"; \
		done; \
	fi; \
	echo "---" >> "$$filename"; \
	echo "\nNew post created: $$filename"

.PHONY: all install build serve dev clean prod deploy test check_links new_post