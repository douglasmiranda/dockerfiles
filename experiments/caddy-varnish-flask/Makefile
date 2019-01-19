.PHONY: help
.DEFAULT_GOAL:=help

help: ## show make targets
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | \
	awk 'BEGIN {FS = ":.*?## "}; \
		{printf "\033[36m%-20s", $$1} \
		/#__danger/ {printf "\033[31m%s ", "DANGER"} \
		{gsub(/#__danger /, ""); printf "\033[0m%s\n", $$2}'


build: ## Build our Flask service Docker image
	docker build -t experiment--caddy-varnish-flask flask/.
	docker build -t experiment--caddy-varnish-flask-varnish varnish/.

deploy-simple: ## Deploy simple example (docker-stack.simple.yml)
	docker stack deploy --compose-file=docker-stack.simple.yml experiment-caddy-varnish

