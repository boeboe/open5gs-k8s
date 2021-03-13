FROM debian:stable-slim

ARG VERSION=main

LABEL maintainer="Bart Van Bos <bartvanbos@gmail.com>"
LABEL name="Open5GS Docker Image"
LABEL description="Open5GS is a C-language Open Source implementation of 5GC and EPC, i.e. the core network of NR/LTE network"
LABEL source-repo="https://github.com/boeboe/open5gs"
LABEL version=${VERSION}

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && \
    apt-get -yq dist-upgrade && \
    apt-get --no-install-recommends -qqy install python3-pip python3-setuptools python3-wheel ninja-build build-essential flex \
    bison git libsctp-dev libgnutls28-dev libgcrypt-dev libssl-dev libidn11-dev libmongoc-dev libbson-dev libyaml-dev \
    libmicrohttpd-dev libcurl4-gnutls-dev meson iproute2 libnghttp2-dev iptables iputils-ping tcpdump cmake curl gnupg && \ 
    git clone --recursive https://github.com/open5gs/open5gs && cd open5gs && git checkout ${VERSION} && \
    meson build --prefix=/ && ninja -C build && cd build && ninja install && \
    apt-get remove -y python3-pip python3-setuptools python3-wheel ninja-build build-essential flex \
    bison git libsctp-dev libgnutls28-dev libgcrypt-dev libssl-dev libidn11-dev libmongoc-dev libbson-dev libyaml-dev \
    libmicrohttpd-dev libcurl4-gnutls-dev meson libnghttp2-dev cmake gnupg && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /
