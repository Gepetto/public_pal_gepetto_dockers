REGISTRY_NAME:="talos"
WORK_DIR:=/home/user/exchange

.PHONY: all
all: build-no-cache

build-no-cache:
	docker build -t $(REGISTRY_NAME) --no-cache --network=host .
build-cache:
	docker build -t $(REGISTRY_NAME) --network=host .

run-no-build:
	./pal_docker_utils/scripts/pal_docker.sh -w $(WORK_DIR) -it $(REGISTRY_NAME) bash

run: build-cache run-no-build

connect:
	docker exec --workdir=$(WORK_DIR) -u user -it `docker ps --latest --quiet` bash
