#!/bin/bash

# Example run: ./security_openvas.sh www.host.com,123.123.123.123,www.test.com

HOSTS="$1"

printf "Running security: OpenVAS\n"

docker pull ictu/openvas-docker
docker run --rm -v $(pwd):/openvas/results/:rw ictu/openvas-docker /openvas/run_scan.py $HOSTS openvas_scan

exit 0
