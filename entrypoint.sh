#!/bin/sh
set -e
#
# tiddlywiki-docker
# entrypoint script
#

WIKI_DIR=${DATA_DIR}/wiki

# init wiki directory on first startup if empty
if [ ! -f ${WIKI_DIR}/tiddlywiki.info ]
then
    echo "[INFO] $(date -Iseconds): Initializing wiki directory on first startup"

    if [ -n "$TIDDLYWIKI_BARE" ]
    then
        # use tiddlywiki to init wiki directory
        mkdir -p $WIKI_DIR
        tiddlywiki $WIKI_DIR --init server
    else
        # use wiki template to init wiki directory
        mv -f /template/* /wiki/
    fi
fi

# parse auth config from environment variables
if [ -n "$TIDDLYWIKI_AUTH_HEADER" ]
then
    echo "[INFO] $(date -Iseconds): Starting tiddlywiki with header authentication"
    AUTH_ARGS="\
        authenticated-user-header=$TIDDLYWIKI_AUTH_HEADER \
        readers=${TIDDLYWIKI_READERS:-(authenticated)} \
        writers=${TIDDLYWIKI_WRITERS:-(authenticated)}"
elif [ -n "$TIDDLYWIKI_USERNAME" ] && [ -n "$TIDDLYWIKI_PASSWORD" ]
then
    echo "[INFO] $(date -Iseconds): Starting tiddlywiki with basic authentication"
    AUTH_ARGS="username=$TIDDLYWIKI_USERNAME password=$TIDDLYWIKI_PASSWORD"
else
    echo "[WARNING] $(date -Iseconds): Starting tiddlywiki with Anonymous Access"
    AUTH_ARGS=""
fi

# fix permissions for tiddly user
chown -R tiddly ${WIKI_DIR}
chmod -R u+rw ${WIKI_DIR}

# start tiddlywiki unless directed to do something else
if [ -z "$@" ]
then
    # drop root permissions by switch to tiddly user
    exec su -m tiddly -c "tiddlywiki ${WIKI_DIR} --listen host=0.0.0.0 port=8080 gzip=yes debug-level=$TIDDLYWIKI_DEBUG $AUTH_ARGS"
else
    exec "$@"
fi
