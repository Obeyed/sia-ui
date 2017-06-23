# run the following to allow docker to use X server
#   xhost local:root
#
# once the container has been run once, you should chown of the created folders
#   sudo chown -R $(whoami) ~/.siacoin
#
# run the container with
#   docker run --rm -it \
#      -v /tmp/.X11-unix:/tmp/.X11-unix \
#      -e DISPLAY=unix$DISPLAY \
#      -v ~/.siacoin/:/root/ \
#      -p 9981:9981 -p 9982:9982 \
#      obeid/sia

FROM debian:sid-slim

LABEL maintainer "Elias Obeid <ekobeid@gmail.com>"

ENV SIAD_VERSION 1.2.2
ENV SIAUI_VERSION SIAD_VERSION
ENV SIAD_FILE Sia-v${SIAD_VERSION}-linux-amd64.zip
ENV SIAUI_FILE Sia-UI-v${SIAUI_VERSION}-linux-x64.zip

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
      libxss1 \ 
      build-essential \
      curl \
      gnupg \
      unzip \
      libgtk2.0-0 \
      libx11-xcb-dev \
      ca-certificates \
      libxtst-dev \
      libgconf2-dev \
      libnss3-dev \
      libasound2-dev \
      libcanberra-gtk-module \
    && update-ca-certificates \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN rm -f \
      /etc/apt/sources.list.d/node.js.list \
      /etc/apt/sources.list.d/nodesource.list \
    && curl -sL https://deb.nodesource.com/setup_6.x | bash -
RUN rm -f \
      /etc/apt/sources.list.d/node.js.list \
      /etc/apt/sources.list.d/nodesource.list \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
      nodejs \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN curl -sLO https://github.com/NebulousLabs/Sia/releases/download/v${SIAD_VERSION}/${SIAD_FILE} \ 
    && curl -sLO https://github.com/NebulousLabs/Sia-UI/releases/download/v${SIAUI_VERSION}/${SIAUI_FILE} \
    && unzip -d /opt ${SIAD_FILE} \
    && unzip -d /opt ${SIAUI_FILE} \
    && rm -f Sia*.zip

ENTRYPOINT ["/opt/Sia-UI"]
