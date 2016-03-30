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
}

function build-hosts() {
  echo "build hosts in $HOSTS_DIR"

  for host_dir in $(ls $HOSTS_DIR); do \
    full_dir=$HOSTS_DIR/$host_dir
    if [ -d $full_dir ]; then
      echo "running 'make build' in $full_dir"
      cd $full_dir; make build
      echo "finished 'make build'"
    fi
  done

  echo "build hosts finished"
}

function run() {
  echo "run hosts in $HOSTS_DIR"

  for host_dir in $(ls $HOSTS_DIR); do \
    full_dir=$HOSTS_DIR/$host_dir
    if [ -d $full_dir ]; then
      echo "running 'make run' in $full_dir"
      cd $full_dir; make run;
      echo "'make run' finished"
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
