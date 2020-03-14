FROM alpine
LABEL maintainer="Youenn Piolet <piolet.y@gmail.com>" \
      version="1.0.0" \
      description="NINJAM server"

WORKDIR /app
RUN set -x \
      && apk add --update git make g++ libstdc++ \
      && git clone https://www-dev.cockos.com/ninjam/ninjam.git /app \
      && cd /app/ninjam/server && make \
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
