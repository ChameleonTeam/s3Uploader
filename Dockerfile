FROM python:3.8-alpine

LABEL "com.github.actions.name"="S3 Upload"
LABEL "com.github.actions.description"="Sync a directory to an AWS S3 repository"

LABEL version="0.0.1"
LABEL repository="https://github.com/ChameleonTeam/s3Uploader"
LABEL maintainer="Andres Ruiz Carrasco"

# https://github.com/aws/aws-cli/blob/master/CHANGELOG.rst
ENV AWSCLI_VERSION='1.18.14'

RUN pip install --quiet --no-cache-dir awscli==${AWSCLI_VERSION}

ADD entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
