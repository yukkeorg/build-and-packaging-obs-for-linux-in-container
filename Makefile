UBUNTU_IMAGE_TAG := lunar
#OBS_GIT_TAG := master
OBS_GIT_TAG := 29.1.3
DOCKER_TAG_BASE := build-obs-studio
DOCKER_IMAGE_TAG := $(DOCKER_TAG_BASE):$(OBS_GIT_TAG)
CONTAINER_NAME := $(DOCKER_TAG_BASE)-$(shell date +%s)

BUILD_NO_CACHE :=


all: copy_to_local

copy_to_local: build
	docker container cp $(CONTAINER_NAME):/obs-studio/build/obs-studio-$(OBS_GIT_TAG)-Linux.deb .
	docker container stop $(CONTAINER_NAME)

build: build_image
	docker container create --name "${CONTAINER_NAME}" "$(DOCKER_IMAGE_TAG)"
	docker container start $(CONTAINER_NAME)
	docker container exec $(CONTAINER_NAME) ./CI/build-linux.sh -pkg

build_image:
	docker image build $(BUILD_NO_CACHE) \
					   -t "$(DOCKER_IMAGE_TAG)" \
					   --build-arg OBS_GIT_TAG="$(OBS_GIT_TAG)" \
					   --build-arg UBUNTU_IMAGE_TAG="$(UBUNTU_IMAGE_TAG)" .
