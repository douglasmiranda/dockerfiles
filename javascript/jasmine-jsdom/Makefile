.PHONY: test
.DEFAULT_GOAL := help

# You may want to install awk if you don't have already
# google it: Install awk in Windows|Linux|MacOS
help: ## show make targets
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | \
	awk 'BEGIN {FS = ":.*?## "}; \
		{printf "\033[36m%-25s", $$1} \
		/#__danger/ {printf "\033[31m%s ", "DANGER"} \
		{gsub(/#__danger /, ""); printf "\033[0m%s\n", $$2}'

test: ## run jasmine tests inside a Docker container
	# Run in your shell: docker run --rm -v "$PWD/example:/example" douglasmiranda/jasmine-jsdom jasmine example/test.js
	docker run --rm -v "$(PWD)/example:/example" douglasmiranda/jasmine-jsdom jasmine example/test.js
