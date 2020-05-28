#!/bin/sh

set -e

if [ -z "$AWS_S3_BUCKET" ]; then
  echo "AWS_S3_BUCKET is not set"
  exit 1
fi

if [ -z "$AWS_ACCESS_KEY_ID" ]; then
  echo "AWS_ACCESS_KEY_ID is not set"
  exit 1
fi

if [ -z "$AWS_SECRET_ACCESS_KEY" ]; then
  echo "AWS_SECRET_ACCESS_KEY is not set"
  exit 1
fi

# Default eu-west-1
if [ -z "$AWS_REGION" ]; then
  AWS_REGION="eu-west-1"
fi

# Create a dedicated profile for this action to avoid conflicts
aws configure --profile s3-upload-action <<-EOF > /dev/null 2>&1
${AWS_ACCESS_KEY_ID}
${AWS_SECRET_ACCESS_KEY}
${AWS_REGION}
text
EOF

sh -c "aws s3 cp ${SOURCE_DIR} s3://${AWS_S3_BUCKET}/${DEST_DIR} \
              --profile s3-upload-action \
              --no-progress \
              $*"

# Clear out credentials after we're done.
# https://forums.aws.amazon.com/thread.jspa?threadID=148833
aws configure --profile s3-upload-action <<-EOF > /dev/null 2>&1
null
null
null
text
EOF
