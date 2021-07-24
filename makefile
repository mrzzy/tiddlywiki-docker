#
# tiddywiki-docker
# Project makefile
#


TIDDLYWIKI_VERSION:=5.1.23
IMAGE_VERSION:=0.0.1
DOCKER_USER:=mrzzy
DOCKER_REPO:=ghcr.io
IMAGE:=$(DOCKER_REPO)/$(DOCKER_USER)/tiddywiki-docker
IMAGE_TAG:=$(TIDDLYWIKI_VERSION)-$(IMAGE_VERSION)

.PHONY: $(IMAGE)
.DEFAULT: $(IMAGE)

$(IMAGE): Dockerfile entrypoint.sh
	docker build -f $< -t $(IMAGE):$(IMAGE_TAG) .

