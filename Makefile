SRC := ./src
BUILD := ./public

default: build templates ## build

help: ## Prints help for targets with comments.
	@grep -E '^[a-zA-Z._-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-15s\033[0m %s\n", $$1, $$2}'

build: ## Copies src files to public directory.
	@rsync -a --delete ${SRC}/ ${BUILD}/ && find ${BUILD}/ -type f -name "\.*" -print0 | xargs -0 rm

clean: ## Remove build directory.
	@if [ -d ${BUILD} ]; then rm -rf ${BUILD}; fi && mkdir ${BUILD}

sync: ## Push compiled site to remote server.
	@rsync --recursive --delete --rsh=ssh --exclude=".*" --quiet ${BUILD}/ waitstaff_deploy:/usr/local/www/gwengween.com

web: clean build templates sync ## Build and sync to remote server.

serve: ## Start simple HTTP server.
	@python -m SimpleHTTPServer > /dev/null 2>&1 &

stop: ## Stop HTTP server.
	@pgrep python -m SimpleHTTPServer | xargs kill

templates: ## Compiles SVGs into HTML file.
	@./svg-templates.sh
