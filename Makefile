IMAGE_TAG   ?= v0.0.2
IMAGE_NAME  ?= php81-debian
VENDOR_NAME  = rapita

DIR = $(notdir $(shell pwd))

.SILENT: ;               # no need for @
.ONESHELL: ;             # recipes execute in same shell
.NOTPARALLEL: ;          # wait for this target to finish
Makefile: ;              # skip prerequisite discovery

.PHONY: bash
bash:
	docker run -it $(VENDOR_NAME)/$(IMAGE_NAME):$(IMAGE_TAG) bash

.PHONY: build
build:
	docker build -t $(VENDOR_NAME)/$(IMAGE_NAME):$(IMAGE_TAG) --rm .

.PHONY: push
push:
	docker push $(VENDOR_NAME)/$(IMAGE_NAME):$(IMAGE_TAG)

%:
	@:
