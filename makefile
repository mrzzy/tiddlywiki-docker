#
# tiddlywiki-docker
# Project makefile
#


TIDDLYWIKI_VERSION?=5.1.22
IMAGE_VERSION?=latest
DOCKER_USER:=mrzzy
DOCKER_REPO:=ghcr.io
IMAGE:=$(DOCKER_REPO)/$(DOCKER_USER)/tiddlywiki
IMAGE_TAG:=$(TIDDLYWIKI_VERSION)-$(IMAGE_VERSION)

.PHONY: $(IMAGE) run push push-latest
.DEFAULT: $(IMAGE)

$(IMAGE): Dockerfile entrypoint.sh
	docker build --build-arg TIDDLYWIKI_VERSION=$(TIDDLYWIKI_VERSION) \
		-f $< -t $(IMAGE):$(IMAGE_TAG) .
	docker tag $(IMAGE):$(IMAGE_TAG) $(IMAGE):latest

run:
	docker run -it --init \
		-p 8080:8080  \
		-v $(shell pwd)/wiki:/wiki \
		$(IMAGE):$(IMAGE_TAG)

push:
	docker push $(IMAGE):$(IMAGE_TAG)

push-latest:
	docker push $(IMAGE):latest
