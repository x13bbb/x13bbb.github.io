# makefile
- `make install` first to install deps
- `make dev` will start the local server and watch for changes and build incrementally
there's also the following utils:
- `make new_post` makes an empty new post file
- `make check_links` 
- `make clean` deletes the `_site` folder
- `make build`
- `make prod` merges main to live if you don't want to use the github actions trigger

checkout the `Makefile` for more info

# ci/cd
including '[deploy]' in the commit message will trigger a merge from main to live and live by github-pages default will deploy the site

# todo
- [ ] a books library
- [ ] look into faraday-retry middle ware
- [ ] rspec and tests
- [ ] clean up old S/CSS, layouts, HTML
- [ ] styling

## Attribution

the [midnight](https://github.com/pages-themes/midnight) theme by the [pages-themes](https://github.com/pages-themes/midnight/graphs/contributors) team is licensed under [CC0 1.0 Universal](https://github.com/pages-themes/midnight/blob/master/LICENSE).

![contributors](https://contrib.rocks/image?repo=pages-themes/midnight)
