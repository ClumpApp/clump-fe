##
## Build
##
FROM ubuntu:latest AS build

RUN apt-get update && apt-get -y install git curl unzip

RUN git clone https://github.com/flutter/flutter.git /flutter
ENV PATH="${PATH}:/flutter/bin:/flutter/bin/cache/dart-sdk/bin"

RUN flutter channel stable
RUN flutter config --enable-web

RUN mkdir /app/
COPY . /app/

WORKDIR /app/
RUN flutter build web --web-renderer canvaskit --release 

##
## Containerize
##
FROM nginx:stable-alpine

WORKDIR /
COPY --from=build /app/build/web /usr/share/nginx/html
