# Docker Image for mdbook-katex

Alpine-based Docker Image for [mdbook](https://github.com/rust-lang/mdBook) and [mdbook-katex](https://github.com/lzanini/mdbook-katex).

![Docker Hub](https://dockeri.co/image/eliyip/mdbook-katex)

## Getting started

You can pull `latest`(about `10MB`) or `latest-slim`(about `5MB`, recommend) tag with command:

```bash
docker pull eliyip/mdbook-katex:latest-slim
```

Then use like this(`project` stores your mdbook files):

```bash
docker run --rm -v ./project:/book eliyip/mdbook-katex:latest-slim
```

Or you can use it for preview with `docker compose`:

```yaml
version: '3'

services:
  mdbook:
    image: eliyip/mdbook-katex:latest-slim
    container_name: mdbook
    ports:
      - 3000:3000
    volumes:
      - ${PWD}:/book
    command:
      - serve
      - --hostname
      - '0.0.0.0'
```

## Use it in CI/CD

An example CI/CD drone configure:

```yaml
kind: pipeline
type: docker
name: default

steps:
  - name: build
    image: eliyip/mdbook-katex:latest-slim
    commands:
      - mdbook build

  - name: deploy
    image: drillster/drone-rsync
    settings:
      recursive: true
      delete: true
      args: "--backup"
      source: /drone/src/book/
      target:
        from_secret: remote_target
      hosts:
        from_secret: ssh_host
      user:
        from_secret: ssh_username
      key:
        from_secret: ssh_key
      port:
        from_secret: ssh_port
```
