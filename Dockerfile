ARG UBUNTU_IMAGE_TAG

FROM ubuntu:${UBUNTU_IMAGE_TAG}

ARG OBS_GIT_TAG

ENV TERM=xterm
ENV BUILD_FOR_DISTRIBUTION=true

RUN apt-get -y update
RUN apt-get -y install git sudo libnss3 libnspr4 file libatk-bridge2.0-0 libatk1.0-0 libatspi2.0-0 libxdamage1

WORKDIR /
RUN git clone --recursive https://github.com/obsproject/obs-studio.git -b ${OBS_GIT_TAG}

WORKDIR /obs-studio

CMD [ "sleep", "15m" ]
