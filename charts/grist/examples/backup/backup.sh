#!/bin/bash -xe

set -Eeuox pipefail

DATE=$(date +'%Y%m%d%H%M')

mc alias set s3 "$S3_ENDPOINT_URL" "$S3_ACCESS_KEY" "$S3_SECRET_KEY" --api s3v4

mkdir -p /tmp/backup/

set +eo pipefail
# need to manually handle tar failure
tar cvf - -C /data/ . 2> >(tee /tmp/tar.log >&2) | pigz > /tmp/backup/$DATE.tar.gz
RESULT=("${PIPESTATUS[@]}")
if [ "${RESULT[1]}" -ne 0 ]
then
    echo "pigz failed"
    exit "${RESULT[1]}"
fi
if [ "${RESULT[0]}" -ne 0 ]
then
    # Check if tar failure is important or not
    if [[ -n "$(cat /tmp/tar.log | grep '^tar: ' | grep -v '^tar: .: file changed as we read it$' | grep -v '^tar: ./docs: file changed as we read it$')" ]]
    then
        echo "tar failed"
        exit "${RESULT[0]}"
    fi
fi

set -eo pipefail

tar -I pigz -tf /tmp/backup/$DATE.tar.gz >/dev/null

mc cp "/tmp/backup/$DATE.tar.gz" "s3/$S3_BUCKET"
