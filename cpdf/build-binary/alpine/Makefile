# git tag or branch you want to freeze (git checkout) so you can build a specific version
GIT_BRANCH_OR_TAG:=v2.2.1
# docker image for building your stuff
DOCKER_IMAGE_TAG_NAME:=bctwd-build_cpdf_ocaml_opam_alpine
# will copy the result of the building process here
# on host and container we'll have this directory, so we can map with volumes (docker) 
BUILD_RESULT_DIR_NAME:=done

.PHONY: build
.DEFAULT_GOAL:=help

help: ## show make targets
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {sub("\\\\n",sprintf("\n%22c"," "), $$2);printf " \033[36m%-20s\033[0m  %s\n", $$1, $$2}' $(MAKEFILE_LIST)

build: clean result-dir ## clean and build a new fresh version
	docker build -t $(DOCKER_IMAGE_TAG_NAME) .
	docker run --rm \
		   -e GIT_BRANCH_OR_TAG=$(GIT_BRANCH_OR_TAG) \
		   -e BUILD_RESULT_DIR_NAME=$(BUILD_RESULT_DIR_NAME) \
		   -v "$(CURDIR)/$(BUILD_RESULT_DIR_NAME)/:/$(BUILD_RESULT_DIR_NAME)/" \
		   $(DOCKER_IMAGE_TAG_NAME)

result-dir: ## create build result directory
	mkdir -p ./$(BUILD_RESULT_DIR_NAME)/

clean: ## remove build directory
	rm -rf ./$(BUILD_RESULT_DIR_NAME)/

clean-image: ## remove docker image used for building
	docker rmi $(DOCKER_IMAGE_TAG_NAME)
