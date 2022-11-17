ARG UBUNTU_IMAGE_TAG

FROM ubuntu:${UBUNTU_IMAGE_TAG}

ARG OBS_GIT_TAG

ENV TERM=xterm
ENV BUILD_FOR_DISTRIBUTION=true

RUN apt-get -y update
RUN apt-get -y install git sudo libnss3 libnspr4 file
# RUN apt-get -y build-dep obs-studio

WORKDIR /
RUN git clone --recursive https://github.com/obsproject/obs-studio.git -b ${OBS_GIT_TAG}

WORKDIR /obs-studio
RUN ./CI/build-linux.sh -pkg
