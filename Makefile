GIT_TAG := 28.0.3
IMAGE_TAG := build-obs-studio
CONTAINER_NAME := ${IMAGE_TAG}-$(shell date +%s)

all: copy_to_local

copy_to_local: build
	docker container cp ${CONTAINER_NAME}:/obs-studio/build/obs-studio-${GIT_TAG}-Linux.deb .

build:
	docker image build -t ${IMAGE_TAG} --build-arg GIT_TAG=${GIT_TAG} .
	docker container create --name ${CONTAINER_NAME} --rm -it ${IMAGE_TAG} /bin/bash
