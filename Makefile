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
	$(JEKYLL) build

# Serve the site locally
dev:
	$(JEKYLL) serve --port 4001 --incremental

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
	date=$$(date +%Y-%m-%d); \
	slug=$$(echo "$$title" | sed -e 's/[^[:alnum:]]/-/g' | tr -s '-' | tr A-Z a-z); \
	filename="_posts/$$date-$$slug.md"; \
	echo "---" > "$$filename"; \
	echo "layout: post" >> "$$filename"; \
	echo "title: \"$$title\"" >> "$$filename"; \
	echo "date: $$date" >> "$$filename"; \
	echo "description: \"$$desc\"" >> "$$filename"; \
	echo "categories: []" >> "$$filename"; \
	echo "---" >> "$$filename"; \
	echo "\nNew post created: $$filename"

.PHONY: all install build serve dev clean prod deploy test check_links new_post