FROM alpine

ARG APP_COMMIT=658f12f1cc37088036ab47e4a5f18b0e1c1f8e8e
ARG APP_REPO=https://www-dev.cockos.com/ninjam/ninjam.git
ARG CONTAINER_BUILD_DATE
ARG CONTAINER_VCS_REF

LABEL org.label-schema.build-date=$CONTAINER_BUILD_DATE \
      org.label-schema.name="ninjamserver" \
      org.label-schema.description="A light Alpine NINJAM server container" \
      org.label-schema.url="https://github.com/uZer/docker-ninjamserver" \
      org.label-schema.vcs-ref="$APP_COMMIT~$CONTAINER_VCS_REF" \
      org.label-schema.vcs-url="$APP_REPO" \
      org.label-schema.version=$CONTAINER_VCS_REF \
      org.label-schema.schema-version="1.0"

WORKDIR /app
RUN set -x \
      && apk add --update git make g++ libstdc++ \
      && git clone $APP_REPO /app \
      && cd /app/ninjam/server && git checkout $NINJAM_COMMIT && make \
      && cp ninjamsrv /bin \
      && cp example.cfg /app/ninjam_server.cfg \
      && cp cclicense.txt /app \
      && apk del git make g++ \
      && rm -rf /var/cache/apk/* /app/ninjam \
      \
      && addgroup app \
      && adduser -G app -g "Ninjam" -s /bin/ash -D app

USER app
EXPOSE 2049

CMD ["ninjamsrv", "/app/ninjam_server.cfg"]
