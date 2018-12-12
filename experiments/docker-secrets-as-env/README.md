# Docker Secrets to Environment Variables

When using Docker Secrets to store sensitive data, you'll have at the end mounted read-only files at ``/run/secrets/SECRET_NAME``. A common way to export/set environment variables is to define environment variables like ``POSTGRES_PASSWORD_FILE`` containing the location of the secret file, e.g. ``/run/secrets/POSTGRES_PASSWORD``.

But I just want to say I want to use ``MY_SECRET`` and simply have it available when running my command inside the container.

So I wrote [this script](docker-secrets-to-env-var.sh), and it's easy to use:

- Get the [script](docker-secrets-to-env-var.sh)
- Add to your entrypoint.sh
  - you could just put in the same directory and simply: ``source docker-secrets-to-env-var.sh``

You can take a look in [my entrypoint](entrypoint.sh) for this example.

Another file that may help you is my [docker-compose.yml](docker-compose.yml).

Just run:

```
docker-compose run simple
docker-compose run debug
docker-compose run custom-docker-secrets-dir
```

You'll what's happening in the logs, you can run with ``docker stack`` command too, and check the logs after.

You can always check if your config management/lib/package does offer the feature of reading from files like I do with [gconfigs](https://github.com/douglasmiranda/gconfigs#secrets).
