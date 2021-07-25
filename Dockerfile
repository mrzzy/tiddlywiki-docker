#
# tiddlywiki-docker
# container Dockerfile
#

FROM node:14.17-alpine3.11

# setup workdir & user for tiddlywiki
WORKDIR /home/tiddly
RUN addgroup --gid 12820 tiddly \
    && adduser --uid 12820  \
        --ingroup tiddly \
        --home /home/tiddly \
        --disabled-password tiddly

# install tiddlywiki with npm
ARG TIDDLYWIKI_VERSION=5.1.23
RUN npm install -g tiddlywiki@${TIDDLYWIKI_VERSION}

# setup directory for wiki
ENV WIKI_DIR=/wiki
RUN mkdir ${WIKI_DIR}

# copy wiki template, plugins & themes
COPY template /template
COPY plugins /plugins
COPY themes /themes

# define plugin, themes search path
ENV TIDDLYWIKI_PLUGIN_PATH="/plugins:/themes"
ENV TIDDLYWIKI_THEME_PATH="/themes"

# copy entrypoint script
COPY entrypoint.sh .

# run tiddlywiki on container start
ENTRYPOINT ["sh", "entrypoint.sh"]
