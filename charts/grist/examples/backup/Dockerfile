FROM alpine:3.12

RUN apk --no-cache add \
    bash \
    pigz \
    tar
COPY --from=minio/mc:RELEASE.2024-03-13T23-51-57Z /bin/mc /bin/mc

COPY ./backup.sh /usr/local/bin/backup.sh
RUN chmod +x /usr/local/bin/backup.sh

VOLUME /data

CMD ["./usr/local/bin/backup.sh"]
