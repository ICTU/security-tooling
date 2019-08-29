#!/bin/bash

# Example run: ./security_dependencycheck.sh /build/src /tmp/report

CUR_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
SOURCE_PATH="$1"
REPORT_PATH="$2"

printf "Running security: Dependency Check\n"

mkdir -p $REPORT_PATH

DOCKER_IMAGE="ictu/owasp-dependency-check"
docker pull ${DOCKER_IMAGE}
cp $CUR_DIR/suppression.xml $SOURCE_PATH/suppression.xml
docker run --rm \
            -v $SOURCE_PATH:/tmp/src \
            -v $REPORT_PATH:/tmp/reports \
            ${DOCKER_IMAGE} \
                --suppression /tmp/src/suppression.xml || true
