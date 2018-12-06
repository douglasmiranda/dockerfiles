# Caddy cache plugin vs Nginx microcaching

Both Caddy and Nginx are acting as reverse proxy to a flask endpoint.

You can start the services using Docker Compose:

```
docker-compose up
```

Caddy will run in ``localhost:81``.
Nginx will run in ``localhost:80``.

I'm providing a Makefile with some ideas on how to execute your benchmarking, but feel free do what you want.

```
> make help
help                show make targets
run                 Run Caddy and Nginx with docker-compose
get                 Make Get requests with httpie
hey                 Load test with "hey"
wrk                 Load test with "wrk"
```

NOTE: Of course Nginx will win, more requests using less resources. With or without cache. But maybe for your not so high traffic web application you can choose the goodies of Caddy web server.
