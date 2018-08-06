.PHONY: help deploy
.DEFAULT_GOAL:=help

help: ## show make targets
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | \
	awk 'BEGIN {FS = ":.*?## "}; \
		{printf "\033[36m%-20s", $$1} \
		/#__danger/ {printf "\033[31m%s ", "DANGER"} \
		{gsub(/#__danger /, ""); printf "\033[0m%s\n", $$2}'

upload:
	rsync -r ./* app@165.227.211.98:~/

deploy: upload ## Deploy to production!
	ssh app@165.227.211.98 \
		"docker stack deploy --with-registry-auth -c docker-stack.caddy.yml devtools;" \
		"docker stack deploy --with-registry-auth -c docker-stack.status.yml devtools;" \
		"docker stack deploy --with-registry-auth -c docker-stack.drone.yml devtools;" \
		"docker stack deploy --with-registry-auth -c docker-stack.registry.yml devtools;"

generate-certs: ## generate docker_auth certs
	cd auth_server/ssl/ && openssl req -x509 -nodes -days 3650 -newkey rsa:4096 -keyout server.key -out server.pem
