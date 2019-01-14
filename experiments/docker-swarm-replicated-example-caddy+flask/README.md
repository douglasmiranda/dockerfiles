# Docker Swarm Mode Replicated Example with Flask and Caddy

Reverse Proxy (Caddy) -> Replicated application (Flask app)

I'm running one replica of our reverse proxy binding to the 80 port of our host system. And 6 replicas of our Flask application.

Some things achieved with this example:

- Replicated web service
- Automatic restart
- Automatic rollback when the update fails
- Kind of a zero downtime deployment

## Docker Swarm

With Docker Swarm we can manage a cluster of Docker Engines, it's relatively easy once you understand the concepts.

More information on Docker Swarm: https://docs.docker.com/engine/swarm/

When you create services to run on Docker Swarm, they are part of a ingress network. Once the request hit this network, it will
be load balanced to one of the replicas.

Reverse Proxy (Caddy, port 80 binded to host) -> (ingress routing mesh) -> Replicated application (6 replicas) (Flask app)

More about Docker Swarm Ingress Network: https://docs.docker.com/engine/swarm/ingress/

### Deploying with docker stack command

Take a look at [docker-stack.yml](docker-stack.yml) and [Makefile](Makefile) and read the docs to learn more about the options and commands I'm using.

Some notes:

Build our Flask app and tag it:

```bash
docker build -t experiment--docker-caddy-flask-replicated flask/.

# OR check Makefile, and:

make build
```

Deploying:

```bash
# manage stacks    | services configuration        | stack name
docker stack deploy --compose-file=docker-stack.yml experiment

# OR check Makefile, and:

make deploy
```

### Update & Rollback

In order to never stop the service when re-deploying or updating stuff, I tell Docker to update and/or rollback 2 at a time since I'm running 6 replicas, I'll never fully stop. And with automatic rollback when the update fails, I'll never replace healthy services with broken things.

```yaml
services:
  flask:
    # ...
    deploy:
      mode: replicated
      replicas: 6
      # ...
      rollback_config:
        parallelism: 2
        # ...
      update_config:
        parallelism: 2
        failure_action: rollback
        # ...
```

Of course it depends on how you tell Docker you're healthy, in this case, I'm simply checking if the endpoint `/` return an `ok` response, you can implement more sophisticated healthchecks.

```yaml
services:
  flask:
    # ...
    healthcheck:
      test:
        - "CMD-SHELL"
        - "wget --spider http://localhost:8000 || exit 1"
```

Test the automatic rollback and zero downtime deployment by breaking/updating our Flask app by breaking the code, rebuilding the image and forcing an update of services.

```bash
# manage services            | service name ($STACK__NAME_$SERVICE__NAME)
docker service update --force experiment_flask

# OR check Makefile, and:

make update
```

OR, as I said the healthcheck will tell if our deploy succeeded or not, so let's just break the healthcheck, checking the wrong port (other than 8000):

```bash
docker service update --health-cmd="wget --spider http://localhost:WRONG-PORT || exit 1" experiment_flask
```

__You'll see something like this happening:__

trying to update the first two replicas
```
experiment_flask
overall progress: 0 out of 6 tasks
1/6: starting  [============================================>      ]
2/6:
3/6: starting  [============================================>      ]
4/6:
5/6:
6/6:
```

update failed, automatic rollback
```
docker service update --health-cmd="wget --spider http://localhost:WRONG-PORT || exit 1" experiment_flask
experiment_flask
overall progress: rolling back update: 4 out of 6 tasks
1/6: preparing [================>                                  ]
2/6: running   [>                                                  ]
3/6: preparing [================>                                  ]
4/6: running   [>                                                  ]
5/6: running   [>                                                  ]
6/6: running   [>                                                  ]
rollback: update rolled back due to failure or early termination of task b9yz49kuu7g9j0mk3vjj8kpr2
```

and finally:
```
experiment_flask
overall progress: rolling back update: 6 out of 6 tasks
1/6: running   [>                                                  ]
2/6: running   [>                                                  ]
3/6: running   [>                                                  ]
4/6: running   [>                                                  ]
5/6: running   [>                                                  ]
6/6: running   [>                                                  ]
rollback: update rolled back due to failure or early termination of task xihih7bfc9w0npice05jmff31
verify: Service converged
```

## Flask app

This Flask app will get the `HOSTNAME` environment variable and print, so we can see what container is responding to our request.

`HOSTNAME` is just the container id (short version).


```python
# ...
@app.route("/")
def index():
    container = os.environ.get("HOSTNAME")
    return f"Hello, I'm a response from this container => {container}"
```

## Caddy (Reverse Proxy)

I'm using Caddy as a Reverse Proxy, you could use Nginx or whatever you want.


__NOTES:__

Use [ctop](https://github.com/bcicen/ctop) or even `docker stats` command to monitor and see container being spawned when you're experimenting.

Type `make help` and see what you can do:

```
make help
help                show make targets
build               Build our Flask service Docker image
deploy              Deploy stack
update              Update services (Force update)
broken-update       Simulate a unsuccessful updating of services
```
