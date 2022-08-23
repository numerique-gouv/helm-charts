#!/bin/bash -xe

set -Eeuox pipefail

DATE=$(date +'%Y%m%d%H%M')

mkdir -p /tmp/backup/

tar -zcvf /tmp/backup/$DATE.tar.gz -C /data/ .
tar -tzf /tmp/backup/$DATE.tar.gz >/dev/null

aws configure set plugins.endpoint awscli_plugin_endpoint

cat > ~/.aws/config <<EOF
[plugins]
endpoint = awscli_plugin_endpoint

[default]
region = $S3_REGION
s3 =
  endpoint_url = $S3_ENDPOINT_URL
  signature_version = s3v4
  max_concurrent_requests = 100
  max_queue_size = 1000
  multipart_threshold = 50MB
  multipart_chunksize = 10MB
s3api =
  endpoint_url = $S3_ENDPOINT_URL
EOF

cat > ~/.aws/credentials <<EOF
[default]
aws_access_key_id=$S3_ACCESS_KEY
aws_secret_access_key=$S3_SECRET_KEY
EOF

aws s3 cp /tmp/$DATE.tar.gz s3://$S3_BUCKET
