# Drone CI/CD + Private Container Registry

I'm going to improve this before I do any complete article or full documentaion about. But if someone want to test, make it better, please do. Any feedback will be appreciated.

## Features

- Deploying with [Docker Swarm](https://docs.docker.com/engine/swarm/).
- Automatic HTTPS with [Caddy](https://github.com/mholt/caddy).
- [Private container registry with authentication and authorization](https://github.com/douglasmiranda/dockerfiles/tree/master/registry-authn-authz).
- Registry using [Minio](https://github.com/minio/minio) as storage so you can move easily from one object storage to another. By default using local storage.

Open docker-stack.drone.yml and provide your own info/configs. The spaces are marked with: `YOUR*` string. (e.g. `YOUR USER`)

- [Drone Documentaion](http://docs.drone.io/installation/)
- Choose if you wanto to integrate with Github, Gitlab or any of the options available. I'm using Gitlab.
- There's no official docs about Drone on Docker Swarm.
- Can't make full use of Docker Secrets unfortunately, more about that below.
- Check Makefile if you want to generate the certificates needed for auth-server.
- Information about user management for Docker Registry [check this](https://github.com/douglasmiranda/dockerfiles/tree/master/registry-authn-authz).

---

Additional notes you may be interested:

CI/CD with Drone:

- [Notes about Drone + Gitlab](https://gist.github.com/douglasmiranda/7387b278cad49cc8780647eaf800d132)
- [Drone agent issues when running with Docker Swarm](https://gist.github.com/douglasmiranda/73a56f51ea50749e0802100cf469c2d8)

Private Container Registry with Docker Registry (Distribution)

- [Docker Registry with authentication and authorization](https://github.com/douglasmiranda/dockerfiles/tree/master/registry-authn-authz)
- [Docker Registry + Minio as file storage issues](https://gist.github.com/douglasmiranda/8510147c901d4ec2c7655ad7b646b51b)

Both Drone and Docker Registry have issues with not loading secrets as files for now (2018-07-22):

- https://github.com/drone/drone/issues/2223
- https://github.com/docker/distribution/issues/2483
