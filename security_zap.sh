#!/bin/bash

# Example run: ./security_zap.sh https://www.host.com /tmp/report

CUR_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
APPLICATION_URL="$1"
REPORT_PATH="$2"

printf "Running security: ZAP\n"

mkdir -p $REPORT_PATH

# Passive scan (short) with max duration of 60 minutes
PASSIVE_SCAN="zap-baseline.py -t $APPLICATION_URL -r report.html -x report.xml -m 60"
# Active scan (more intensive) with max duration of 60 minutes
ACTIVE_SCAN="zap-full-scan.py -t $APPLICATION_URL -r report.html -x report.xml -m 60"

docker pull ictu/zap2docker-weekly

# Passive scan
docker run --rm -v $REPORT_PATH:/zap/wrk:rw -t ictu/zap2docker-weekly $PASSIVE_SCAN

# Active scan
#docker run --rm -v $REPORT_PATH:/zap/wrk:rw -t ictu/zap2docker-weekly $ACTIVE_SCAN

# Passive scan with automatic authentication
#docker run --rm -v $REPORT_PATH:/zap/wrk:rw -t ictu/zap2docker-weekly $PASSIVE_SCAN \
#  --hook=/zap/auth_hook.py \
#  -z "auth.loginurl=$APPLICATION_URL \
#      auth.username="USERNAME" \
#      auth.password="PASSWORD" \
#      auth.auto=1"
            
# Active scan with manual authentication
#docker run --rm -v $REPORT_PATH:/zap/wrk:rw -t ictu/zap2docker-weekly $PASSIVE_SCAN \
#  --hook=/zap/auth_hook.py \
#  -z "auth.loginurl=$APPLICATION_URL \
#      auth.username="USERNAME" \
#      auth.password="PASSWORD" \
#      auth.username_field="USERNAME_FIELD_NAME_OR_ID" \
#      auth.password_field="PASSWORD_FIELD_NAME_OR_ID" \
#      auth.submit_field="SUBMIT_FIELD_NAME_OR_ID" \
#      auth.auto=0"

exit 0
