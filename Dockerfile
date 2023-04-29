FROM alpine:latest

RUN apk upgrade --no-cache
RUN apk add --no-cache build-base git

COPY Makefile *.c *.h *.sh /tmp/microsocks/
RUN cd /tmp/microsocks . && LDFLAGS='-static' make && make prefix=/usr install
RUN rm -rf /tmp/microsocks && apk del --purge --no-cache build-base git && apk add --no-cache dumb-init

USER nobody
ENTRYPOINT ["dumb-init","microsocks"]
EXPOSE 1080/tcp
