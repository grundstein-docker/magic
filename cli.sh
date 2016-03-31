#!/usr/bin/env bash
IMAGE_TAG="wiznwit:magic"

source ../../bin/tasks.sh

HOSTS_DIR=hosts

cachebust=`git ls-remote https://github.com/magic/root.git | grep refs/heads/master | cut -f 1`
echo "building with git hash $cachebust"

function build() {
  docker build \
    --tag $IMAGE_TAG \
    --build-arg CACHEBUST=$cachebust \
    . # dot!

  build-hosts
}

function build-hosts() {
  echo "build hosts in $PWD/$HOSTS_DIR"

  for host_dir in $(ls $HOSTS_DIR); do \
    full_dir=$HOSTS_DIR/$host_dir
    if [ -d $full_dir ]; then
      echo "running 'make build' in $full_dir"
      make -C $full_dir build
      echo "SUCCESS: finished 'make build'"
    else
      echo "FAIL: not a directory: $full_dir"
    fi

  done

  echo "build hosts finished"
}

function run() {
  echo "run hosts in $PWD/$HOSTS_DIR"

  for host_dir in $(ls $HOSTS_DIR); do \
    full_dir=$HOSTS_DIR/$host_dir
    echo "try host in dir: $full_dir"
    if [ -d $full_dir ]; then
      echo "running 'make run' in $full_dir"
      make -C $full_dir run
      echo "SUCCESS: 'make run' finished"
    else
      echo "FAIL: not a directory: $full_dir"
    fi

  done

  echo "run hosts finished"
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
