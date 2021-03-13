FROM node:12.14.1-alpine3.9

ARG VERSION=main

LABEL maintainer="Bart Van Bos <bartvanbos@gmail.com>"
LABEL name="Open5GS WebUI Docker Image"
LABEL description="Open5GS is a C-language Open Source implementation of 5GC and EPC, i.e. the core network of NR/LTE network"
LABEL source-repo="https://github.com/boeboe/open5gs"
LABEL version=${VERSION}

RUN apk update && apk add --no-cache --virtual .build-deps git && \
    git clone https://github.com/open5gs/open5gs.git && \
    cd open5gs && git checkout ${VERSION} && \
    apk del .build-deps

WORKDIR /open5gs/webui

RUN npm install && \
    npm run build

CMD npm run start

EXPOSE 3000