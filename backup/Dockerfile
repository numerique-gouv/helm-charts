FROM alpine:3.12

RUN apk --no-cache add \
    bash \
    py3-pip \
    pigz \
    tar
RUN pip3 install --no-cache-dir \
    awscli \
    awscli-plugin-endpoint

COPY ./backup.sh /usr/local/bin/backup.sh
RUN chmod +x /usr/local/bin/backup.sh

VOLUME /data

CMD ["./usr/local/bin/backup.sh"]
