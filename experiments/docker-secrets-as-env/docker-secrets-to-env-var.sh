#!/bin/sh

set -e

DOCKER_SECRETS_DIR=${DOCKER_SECRETS_DIR:-/run/secrets}

env_secret_debug() {
    # If you want to see the debug messages
    # in order to troubleshooting or something,
    # set the `PARSE_SECRETS_DEBUG` env var in your docker-<compose/stack>.yml
    # Example:
    # services:
    #   app:
    #     ...
    #     environment:
    #       PARSE_SECRETS_DEBUG: "true"
    if [ ! -z "$PARSE_SECRETS_DEBUG" ]; then
        echo -e "\033[1mDEBUG: $@\033[0m"
    fi
}


env_var_from_docker_secret_file() {
    # Create a environment variable in shell given a file.
    # The filename will be the variable name and the value of such variable
    # will be the file's contents.
    #
    # Example:
    # file: /run/secrets/SECRET_1
    # filename (basename): SECRET_1
    # file contents: SECRET 1 VALUE
    # The resulting environment variable will be:
    # SECRET_1=SECRET 1 VALUE
    #
    # Usage: env_var_from_docker_secret_file $secret_file
    #        env_var_from_docker_secret_file /run/secrets/SECRET_1
    secret_file="$1"
    env_secret_debug "Secret file: $secret_file"

    env_key=$(basename $secret_file)
    env_value=$(cat $secret_file)
    export "$env_key"="$env_value"

    env_secret_debug "Enviroment Variable: $env_key=$env_value"
}


auto_set_env_vars() {
    # Searching for all secrets in a given `$DOCKER_SECRETS_DIR`.
    # We'll use each file to create environment variables using
    # the function `env_var_from_docker_secret_file`
    # Usage: auto_set_env_vars $DOCKER_SECRETS_DIR
    #        auto_set_env_vars /run/secrets
    dir="$1"
    for secret_file in $(find $dir -type f); do
        env_var_from_docker_secret_file $secret_file
    done
}

if [[ -d $DOCKER_SECRETS_DIR ]]; then
    auto_set_env_vars $DOCKER_SECRETS_DIR
else
    env_secret_debug "$DOCKER_SECRETS_DIR doesn't exist."
fi

if [ "$PARSE_SECRETS_DEBUG" = "true" ]; then
    echo -e "\n\033[1mExpanded environment variables\033[0m"
    printenv
fi
