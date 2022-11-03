#!/bin/bash

# Example run: ./security_nuclei.sh https://www.host.com /tmp/report

APPLICATION_URL="$1"
REPORT_PATH="$2"

printf "Running security: Nuclei\n"

mkdir -p $REPORT_PATH

docker pull seqhub/nuclei
docker run -v $REPORT_PATH:/var/reports seqhub/nuclei $APPLICATION_URL

exit 0
