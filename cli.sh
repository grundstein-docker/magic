#!/usr/bin/env bash
IMAGE_TAG="wiznwit:magic"

source ../../bin/tasks.sh

HOSTS_DIR=hosts

function build() {
  echo "START: building $CONTAINER_NAME"

  cachebust=`git ls-remote https://github.com/magic/root.git | grep refs/heads/master | cut -f 1`
  echo "building with git hash $cachebust"

  docker build \
    --tag $IMAGE_TAG \
    --build-arg CACHEBUST=$cachebust \
    . # dot!

  build-hosts

  echo "FINISHED: building $CONTAINER_NAME"
}

function build-hosts() {
  echo "START: build hosts in $PWD/$HOSTS_DIR for $CONTAINER_NAME"

  loop-dirs $HOSTS_DIR build

  echo "FINISHED: build hosts in $CONTAINER_NAME"
}

function run() {
  echo "START: run hosts in $PWD/$HOSTS_DIR for $CONTAINER_NAME"

  loop-dirs $HOSTS_DIR run

  echo "FINISHED: run hosts for $CONTAINER_NAME"
}

function update() {
  echo "START: update $CONTAINER_NAME"
  git pull

  loop-dirs $HOSTS_DIR pull

  echo "FINISHED: update $CONTAINER_NAME"
}

function status() {
  git status

  loop-dirs $HOSTS_DIR status
}


function help() {
  echo "\
Usage
make magic-TASK
./cli.sh TASK

TASKS
  build       - build magic-root dependency containers

  build-hosts - build docker containers
  run         - run docker containers

  help        - this help text
"
}

if [ $1 ]
then
  function=$1
  shift
  $function $@
else
  help $@
fi
