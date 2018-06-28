.PHONY: help deploy
.DEFAULT_GOAL:=help


help: ## show make targets
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | \
	awk 'BEGIN {FS = ":.*?## "}; \
		{printf "\033[36m%-20s", $$1} \
		{printf "\033[0m%s\n", $$2}'


generate-certs: ## generate docker_auth certs
	cd auth_server/ssl/ && openssl req -x509 -nodes -days 3650 -newkey rsa:4096 -keyout server.key -out server.pem
