# rauthz

It's Docker Registry setup with authentication and authorization (provided by docker_auth) and HTTPS with Caddy.

## Run

```bash
make  generate-certs  # check Makefile for more info
docker-compose up
```

- `make generate-certs` doesn't generate certificates for HTTPS, it's just the certificates for token authentication between Registry and docker_auth.
- You'll probably want to test locally, so allow docker to use your localhost:80 as an insecure registry. More on [Docker docs](https://docs.docker.com/registry/insecure/).

Let's tag an existent local image so we can push it to our new local registry.

```bash
# host
docker pull alpine
docker tag alpine localhost/douglasmiranda/alpine
```

My custom image for docker_auth ([douglasmiranda/rauthz](https://hub.docker.com/r/douglasmiranda/rauthz/)) has a "user manager" using htpasswd.

We're going to enter the running `auth-server` container (check [docker-compose.yml](https://github.com/douglasmiranda/dockerfiles/tree/master/registry-auth-authz/docker-compose.yml)) and create  a *admin* user.
```bash
# host
docker-compose exec auth-server sh
```

Now inside the container, add user **admin** with password **123**:
```bash
# container
rauthz user add admin
# you will be asked to type the password
```

**NOTE:** you can use `docker-compose run` or `docker exec` commands to run the  rauthz  script and create the users also.

We can now login and push into our new registry with:
```bash
# host
docker login localhost # then type user admin and password 123

docker push localhost/douglasmiranda/alpine
```

Our custom config for docker_auth has two ACLs:

- **admin** user has full access
- Other users have access to pull from their namespace. For example the user **douglasmiranda**, can only pull images from *localhost/douglasmiranda/\**.

You push as an admin to every namespace, and other users only pull, good for deployment.

But you can specify your own sets of ACLs, check the [reference](https://github.com/cesanta/docker_auth/blob/master/examples/reference.yml) and customize your [auth_config.yml](https://github.com/douglasmiranda/dockerfiles/tree/master/registry-auth-authz/auth_server/auth_config.yml).

You can try with the image we just pushed as admin. Create a user **douglasmiranda**, login as your new user and try to push, then try to pull.
```bash
# host
docker-compose exec auth-server sh

# container
rauthz user add douglasmiranda
# you will be asked to type the password

# host
docker login localhost # enter with douglasmrainda and its password

docker push localhost/douglasmiranda/alpine
# you will get something like:
denied: requested access to the resource is denied
unauthorized: authentication required

# But pulling should work:
docker pull localhost/douglasmiranda/alpine
```

### Running on production

For production enviroment, you will want to set your domain in [docker-compose.yml](https://github.com/douglasmiranda/dockerfiles/tree/master/registry-auth-authz/docker-compose.yml) where you find `http://localhost`.

More information about production, please refer to the respective documentation of Docker Registry, docker_auth and Caddy.

## Extra Info

### Caddy

https://github.com/mholt/caddy

Just set the environment variables:

- `$SITE`: address of your registry
Example: http://localhost for local testing and https://example.com for production

- `$EMAIL_TLS`: Caddy will use this to create your Let's encrypt account and get your certificate.

I know Docker Registry could take care of HTTPS, but it's better for managing with a web server. You could easily use Nginx too.

Download, buy or **build** yourself like I did [here](https://github.com/douglasmiranda/dockerfiles/blob/master/caddy/Dockerfile)

### Docker Registry (a.k.a. Distribution)

https://github.com/docker/distribution

I know registry can use  htpasswd, but docker_auth provides me authorization.

### docker_auth - Authentication & Authorization

https://github.com/cesanta/docker_auth

I'm just using multistage build to create the Docker image based on branch/commit hash.

For the final base image, I'm using Alpine and running as non-privileged user.

This image use  htpasswd  to manage users.

I'm using  htpasswd  in order to keep it simple for now, I want to change that in the future, I'm open to suggestions.
