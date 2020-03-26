FROM alpine

ARG APP_NAME="ninjamserver"
ARG APP_DESCRIPTION="A lightweight Alpine NINJAM server container"
ARG APP_VCS_REF="658f12f1cc37088036ab47e4a5f18b0e1c1f8e8e"
ARG APP_VCS_URL="https://www-dev.cockos.com/ninjam/ninjam.git"
ARG APP_VERSION="0.071"
ARG BUILD_DATE
ARG BUILD_VCS_REF
ARG BUILD_VCS_URL="https://github.com/uZer/docker-ninjamserver"

LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.description=$APP_DESCRIPTION \
      org.label-schema.name=$APP_NAME \
      org.label-schema.schema-version="1.0" \
      org.label-schema.url=$BUILD_REPO \
      org.label-schema.vcs-ref=$APP_VCS_REF \
      org.label-schema.vcs-url=$APP_VCS_URL \
      org.label-schema.version=$APP_VERSION

WORKDIR /app
RUN set -x \
      && apk add --update git make g++ libstdc++ \
      && git clone $APP_VCS_URL /app \
      && cd /app/ninjam/server && git checkout $APP_VCS_REF && make \
      && cp ninjamsrv /bin \
      && cp example.cfg /app/ninjam_server.cfg \
      && cp cclicense.txt /app \
      && apk del git make g++ \
      && rm -rf /var/cache/apk/* /app/ninjam \
      \
      && addgroup ninjam \
      && adduser -G ninjam -g "Ninjam" -s /bin/ash -D ninjam

USER ninjam
EXPOSE 2049

CMD ["/bin/ninjamsrv", "/app/ninjam_server.cfg"]
