#!/bin/sh

set -e

source ./docker-secrets-to-env-var.sh

# Do your entrypoint stuff here
# Or leave it blank in case you just need to do things in:
#   Dockerfile: `CMD`
#   OR
#   docker-<compose/stack.yml: `command`

exec "$@"
