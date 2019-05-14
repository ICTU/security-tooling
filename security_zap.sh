#!/bin/bash

# Example run: ./security_zap.sh https://www.host.com /tmp/report

CUR_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
APPLICATION_URL="$1"
REPORT_PATH="$2"

printf "Running security: ZAP\n"

mkdir -p $REPORT_PATH

# Passive scan (shorter)
ZAP_CMD="zap-baseline.py -t $APPLICATION_URL"

# Active scan (more intensive)
#ZAP_CMD="zap-full-scan.py -t $APPLICATION_URL"

# Passive scan with authentication:
#ZAP_CMD="zap-baseline.py -t $APPLICATION_URL -z ""auth.loginurl=$APPLICATION_URL/LOGIN_PAGE auth.username=""USERNAME"" auth.password=""PASSWORD"" auth.auto=1"""

docker pull ictu/zap2docker-weekly
docker run --rm -v $REPORT_PATH:/zap/wrk:rw -t ictu/zap2docker-weekly $ZAP_CMD -r zap-scan-report.html -m 60 -d --hook=/zap/auth_hook.py

exit 0
