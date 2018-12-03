.PHONY: help
.DEFAULT_GOAL:=help

help: ## show make targets
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | \
	awk 'BEGIN {FS = ":.*?## "}; \
		{printf "\033[36m%-20s", $$1} \
		/#__danger/ {printf "\033[31m%s ", "DANGER"} \
		{gsub(/#__danger /, ""); printf "\033[0m%s\n", $$2}'

# https://docs.docker.com/compose/
run: ## Run Caddy and Nginx with docker-compose
	docker-compose up

# https://httpie.org/
get: ## Make Get requests with httpie
	http localhost
	http localhost:81

# https://github.com/rakyll/hey
hey: ## Load test with "hey"
	# Nginx
	hey -n 1000 -c 50 http://localhost
	sleep 5;
	# Caddy
	hey -n 1000 -c 50 http://localhost:81

# https://github.com/wg/wrk
wrk: ## Load test with "wrk"
	# Nginx
	wrk -t5 -c10 -d10s http://localhost
	sleep 5;
	# Caddy
	wrk -t5 -c10 -d10s http://localhost:81
