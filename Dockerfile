FROM ubuntu:18.04 AS build
WORKDIR /tmp/build
ENV GOPATH /tmp/build
RUN apt-get update \
    && apt-get install -y --no-install-recommends -y golang git ca-certificates build-essential \
    && go get -u github.com/folbricht/desync/cmd/desync

FROM ubuntu:18.04 AS runtime
COPY --from=build /tmp/build/bin/desync /usr/local/bin/
WORKDIR /tmp
ENTRYPOINT [ "/usr/local/bin/desync" ]
CMD [ "--help" ]
