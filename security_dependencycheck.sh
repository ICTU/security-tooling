#!/bin/bash

# Example run: ./security_dependencycheck.sh /build/src /tmp/report
# Exclude format: --exclude \"**/myfolder/**\"

CUR_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
SOURCE_PATH="$1"
REPORT_PATH="$2"

DC_VERSION="latest"
DC_DIRECTORY=$HOME/OWASP-Dependency-Check
DATA_DIRECTORY="$DC_DIRECTORY/data"
CACHE_DIRECTORY="$DC_DIRECTORY/data/cache"

if [ ! -d "$DATA_DIRECTORY" ]; then
    echo "Initially creating persistent directory: $DATA_DIRECTORY"
    mkdir -p "$DATA_DIRECTORY"
fi
if [ ! -d "$CACHE_DIRECTORY" ]; then
    echo "Initially creating persistent directory: $CACHE_DIRECTORY"
    mkdir -p "$CACHE_DIRECTORY"
fi
if [ ! -d "$REPORT_PATH" ]; then
    echo "Initially creating persistent directory: $REPORT_PATH"
    mkdir -p "$REPORT_PATH"
fi

printf "Running security: Dependency Check\n"

docker pull owasp/dependency-check:$DC_VERSION

cp $CUR_DIR/suppression.xml $SOURCE_PATH/security/dependency-check-suppression.xml
docker run --rm \
            -e user=$USER \
            -u $(id -u ${USER}):$(id -g ${USER}) \
            --volume $SOURCE_PATH:/src:z \
            --volume $REPORT_PATH:/report:z \
            --volume "$DATA_DIRECTORY":/usr/share/dependency-check/data:z \
            owasp/dependency-check:$DC_VERSION \
                --scan /src \
                --format "ALL" \
                --out /report \
                # Use suppression like this: (where /src == $pwd)
                # --suppression "/src/security/dependency-check-suppression.xml"
