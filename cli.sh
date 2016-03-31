#!/usr/bin/env bash
CONTAINER_NAME='magic'
IMAGE_TAG="wiznwit:magic"

source ../../bin/tasks.sh

HOSTS_DIR=hosts

function build() {
  echo-start "build"

  cachebust=`git ls-remote https://github.com/magic/root.git | grep refs/heads/master | cut -f 1`
  echo "building with git hash $cachebust"

  docker build \
    --tag $IMAGE_TAG \
    --build-arg CACHEBUST=$cachebust \
    . # dot!

  build-hosts

  echo-finished "build"
}

function build-hosts() {
  echo-start "build-hosts"

  loop-dirs $HOSTS_DIR build

  echo-finished "build-hosts"
}

function run() {
  echo-start "run"

  loop-dirs $HOSTS_DIR run

  echo-finished "run"
}

function update() {
  echo-start "update"

  loop-dirs $HOSTS_DIR update

  echo-finished "update"
}

function status() {
  echo-start "status"

  loop-dirs $HOSTS_DIR status

  echo-finished "status"
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
