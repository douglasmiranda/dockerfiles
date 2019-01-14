.PHONY: help
.DEFAULT_GOAL:=help

help: ## show make targets
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | \
	awk 'BEGIN {FS = ":.*?## "}; \
		{printf "\033[36m%-20s", $$1} \
		/#__danger/ {printf "\033[31m%s ", "DANGER"} \
		{gsub(/#__danger /, ""); printf "\033[0m%s\n", $$2}'


build: ## Build our Flask service Docker image
	docker build -t experiment--docker-caddy-flask-replicated flask/.

deploy: ## Deploy stack
	docker stack deploy --compose-file=docker-stack.yml experiment

update: ## Update services (Force update)
	docker service update --force experiment_flask

broken-update: ## Simulate a unsuccessful updating of services
	docker service update --health-cmd="wget --spider http://localhost:WRONG-PORT || exit 1" experiment_flask
