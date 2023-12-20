# This dockerfile uses extends image https://hub.docker.com/tsenart/vegeta
# VERSION 1
# Author: sinlov
# dockerfile offical document https://docs.docker.com/engine/reference/builder/
# https://hub.docker.com/_/golang
FROM golang:1.20.12 as builder

ARG GO_PKG_RELEASE_VERSION=12.11.1
ARG GO_ENV_PACKAGE_NAME=github.com/tsenart/vegeta
ARG GO_ENV_ROOT_BUILD_BIN_NAME=vegeta
ARG GO_ENV_ROOT_BUILD_BIN_PATH=${GO_ENV_ROOT_BUILD_BIN_NAME}

ARG GO_PATH_SOURCE_DIR=/go/src
RUN mkdir -p ${GO_PATH_SOURCE_DIR}
WORKDIR ${GO_PATH_SOURCE_DIR}
# COPY $PWD ${GO_PATH_SOURCE_DIR}/${GO_ENV_PACKAGE_NAME}

RUN git clone https://${GO_ENV_PACKAGE_NAME}.git -b v${GO_PKG_RELEASE_VERSION} --depth=1 ${GO_ENV_PACKAGE_NAME}
WORKDIR ${GO_PATH_SOURCE_DIR}/${GO_ENV_PACKAGE_NAME}

# proxy golang
RUN go env -w "GOPROXY=https://goproxy.cn,direct"
RUN go env -w "GOPRIVATE='*.gitlab.com,*.gitee.com"

RUN export GOARCH=$(go env GOHOSTARCH)
RUN export GOOS=$(go env GOHOSTOS)

RUN make generate
RUN make vegeta

# https://hub.docker.com/_/alpine
FROM alpine:3.19

ARG DOCKER_CLI_VERSION=${DOCKER_CLI_VERSION}
ARG GO_ENV_PACKAGE_NAME=github.com/tsenart/vegeta
ARG GO_ENV_ROOT_BUILD_BIN_NAME=vegeta
ARG GO_ENV_ROOT_BUILD_BIN_PATH=${GO_ENV_ROOT_BUILD_BIN_NAME}

ARG GO_PATH_SOURCE_DIR=/go/src

# proxy apk mirrors.aliyun.com
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories
RUN apk --no-cache add \
 ca-certificates mailcap curl jq  \
 && apk add --no-cache --virtual .build-deps \
    openssl \
 && rm -rf /var/cache/apk/* /tmp/*

RUN mkdir /app
WORKDIR /app

COPY --from=builder ${GO_PATH_SOURCE_DIR}/${GO_ENV_PACKAGE_NAME}/${GO_ENV_ROOT_BUILD_BIN_PATH} /bin/
ENTRYPOINT [ "vegeta" ]
# CMD ["/bin/vegeta", "--help"]