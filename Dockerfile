# Build image
FROM golang:1.21.1-alpine3.18 as build

ARG REPOSITORY
ARG VERSION

ENV GOPATH /go
ENV PATH $GOPATH/bin:$PATH
ENV GO111MODULE=on

LABEL org.opencontainers.image.source=https://github.com/kymppi/writefreely-docker
LABEL org.opencontainers.image.description="WriteFreely is a clean, minimalist publishing platform made for writers. Start a blog, share knowledge within your organization, or build a community around the shared act of writing."

RUN apk add --update nodejs npm make g++ git
RUN npm install -g less less-plugin-clean-css

RUN mkdir -p /go/src/github.com/writefreely/writefreely/ && \
    git clone $REPOSITORY /go/src/github.com/writefreely/writefreely/ -b $VERSION

WORKDIR /go/src/github.com/writefreely/writefreely/

COPY ./openssl.conf ./openssl.conf
RUN cat ./openssl.conf > /etc/ssl/openssl.cnf

ENV NODE_OPTIONS=--openssl-legacy-provider

RUN make build && \
    make ui

RUN mkdir /stage && \
    cp -R /go/bin \
      /go/src/github.com/writefreely/writefreely/templates \
      /go/src/github.com/writefreely/writefreely/static \
      /go/src/github.com/writefreely/writefreely/pages \
      /go/src/github.com/writefreely/writefreely/keys \
      /go/src/github.com/writefreely/writefreely/cmd \
      /stage && \
      mv /stage/cmd/writefreely/writefreely /stage

# Final image
FROM alpine:3.18

RUN apk add --no-cache openssl ca-certificates

COPY --from=build --chown=daemon:daemon /stage /writefreely
COPY bin/run.sh /writefreely/

WORKDIR /writefreely
VOLUME /data
VOLUME /config
EXPOSE 8080
USER daemon

ENTRYPOINT ["/writefreely/run.sh"]
