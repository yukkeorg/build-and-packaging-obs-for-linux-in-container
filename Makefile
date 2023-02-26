UBUNTU_IMAGE_TAG := kinetic
#OBS_GIT_TAG := master
OBS_GIT_TAG := 29.0.2
DOCKER_TAG_BASE := build-obs-studio
DOCKER_IMAGE_TAG := $(DOCKER_TAG_BASE):$(OBS_GIT_TAG)
CONTAINER_NAME := $(DOCKER_TAG_BASE)-$(shell date +%s)


all: copy_to_local

copy_to_local: build
	docker container cp $(CONTAINER_NAME):/obs-studio/build/obs-studio-$(OBS_GIT_TAG)-Linux.deb .

build:
	docker image build -t $(DOCKER_IMAGE_TAG) --build-arg OBS_GIT_TAG=$(OBS_GIT_TAG) --build-arg UBUNTU_IMAGE_TAG=$(UBUNTU_IMAGE_TAG) .
	docker container create --name $(CONTAINER_NAME) --rm $(DOCKER_IMAGE_TAG)
