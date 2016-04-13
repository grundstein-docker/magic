# grundstein/magic dockerfile
# VERSION 0.0.1

FROM mhart/alpine-node:5.9.1

MAINTAINER Wizards & Witches <dev@wiznwit.com>
ENV REFRESHED_AT 2016-29-03

RUN apk add --no-cache git bash

WORKDIR /srv

ENV NODE_ENV=production

COPY .babelrc package.json build.sh ./

ARG CACHEBUST

RUN npm install --verbose
