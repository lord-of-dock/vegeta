[![GitHub license](https://img.shields.io/github/license/lord-of-dock/vegeta)](https://github.com/lord-of-dock/vegeta)
[![GitHub latest SemVer tag)](https://img.shields.io/github/v/tag/lord-of-dock/vegeta)](https://github.com/lord-of-dock/vegeta/tags)
[![GitHub release)](https://img.shields.io/github/v/release/lord-of-dock/vegeta)](https://github.com/lord-of-dock/vegeta/releases)

# vegeta

![docker version semver](https://img.shields.io/docker/v/sinlov/vegeta?sort=semver)
[![docker image size](https://img.shields.io/docker/image-size/sinlov/vegeta)](https://hub.docker.com/r/sinlov/vegeta)
[![docker pulls](https://img.shields.io/docker/pulls/sinlov/vegeta)](https://hub.docker.com/r/sinlov/vegeta/tags?page=1&ordering=last_updated)

- for [tsenart/vegeta](https://github.com/tsenart/vegeta)
- docker hub see [https://hub.docker.com/r/sinlov/vegeta](https://hub.docker.com/r/sinlov/vegeta)

## usage

To display help:

```bash
$ docker run --rm -i sinlov/vegeta --help
```

For full documentation see [vegeta](https://github.com/tsenart/vegeta)

Example:

```bash
$ docker run --rm -i --entrypoint /bin/sh sinlov/vegeta -c \
  "echo 'GET https://www.example.com' | vegeta attack -rate=10 -duration=30s | tee results.bin | vegeta report"
```

use as exec:

```bash
$ sudo curl -L --fail https://raw.githubusercontent.com/lord-of-dock/vegeta/main/run.sh -o /usr/local/bin/vegeta
$ sudo chmod +x /usr/local/bin/vegeta
# then check
$ vegeta --help
```

Usage in Kubernetes:

```bash
# To display help
$ kubectl run vegeta --rm --attach --restart=Never --image="sinlov/vegeta" -- --help

# test some url
$ kubectl run vegeta --rm --attach --restart=Never --image="sinlov/vegeta" -- sh -c \
"echo 'GET https://www.example.com' | vegeta attack -rate=10 -duration=30s | tee results.bin | vegeta report"
```

## source repo

[https://github.com/lord-of-dock/vegeta](https://github.com/lord-of-dock/vegeta)

### env

- minimum go version: go 1.20
- change `go 1.20`, `^1.20`, `1.20.12` to new go version

### dev mode

```bash
# see help
$ make help
# see or check build env
$ make env

# fast build
$ make all
# clean build
$ make clean

# then test build as test/Dockerfile
$ make dockerTestRestartLatest
# clean test build
$ make dockerTestPruneLatest
```

## Contributing

[![Contributor Covenant](https://img.shields.io/badge/contributor%20covenant-v1.4-ff69b4.svg)](.github/CONTRIBUTING_DOC/CODE_OF_CONDUCT.md)
[![GitHub contributors](https://img.shields.io/github/contributors/lord-of-dock/vegeta)](https://github.com/lord-of-dock/vegeta/graphs/contributors)

We welcome community contributions to this project.

Please read [Contributor Guide](.github/CONTRIBUTING_DOC/CONTRIBUTING.md) for more information on how to get started.

请阅读有关 [贡献者指南](.github/CONTRIBUTING_DOC/zh-CN/CONTRIBUTING.md) 以获取更多如何入门的信息
