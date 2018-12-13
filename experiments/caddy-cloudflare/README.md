# Caddy with Cloudflare plugin

I'm using my [douglasmiranda/caddy:cloudflare](https://hub.docker.com/r/douglasmiranda/caddy/tags/) image, but you can always build or download Caddy with this plugin.

You can build your own Caddy + Cloudflare plugin (or any other plugin) with:

- https://github.com/douglasmiranda/dockerfiles/tree/master/caddy/plugins

If you run this experiment you'll see that just by adding the secrets to the container Caddy will use, that's because the [entrypoint](https://github.com/douglasmiranda/dockerfiles/blob/master/experiments/docker-secrets-as-env/entrypoint.sh) of my container automatically loads docker secrets and set as environment variables.

If you want to know more:

- https://github.com/douglasmiranda/dockerfiles/tree/master/experiments/docker-secrets-as-env

## Run

Open docker-stack-simple.yml and set the environment variables:

```yaml
caddy:
    #...
    environment:
      CLOUDFLARE_EMAIL: YOUR-EMAIL
      CLOUDFLARE_API_KEY: YOUR-API-KEY
```

### run with Docker Compose

```
docker-compose -f docker-stack-simple.yml up
```

### run with Docker Stack

Of course to make it more secure use Docker Secrets instead of Environment Variables to store secrets. Docker Secrets is available when you use [Docker Swarm](https://docs.docker.com/engine/swarm/), so let's deploy with ``docker stack`` command.

First let's create our secrets:

```
printf "YOUR-EMAIL" | docker secret create CLOUDFLARE_EMAIL -
printf "YOUR-API-KEY" | docker secret create CLOUDFLARE_API_KEY -
```

and then:

```
docker stack deploy -c docker-stack-using-secrets.yml caddy_cloudflare_sample
```
