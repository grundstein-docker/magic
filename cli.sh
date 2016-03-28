#!/usr/bin/env bash

source ../bin/tasks.sh

HOSTS_DIR=hosts

function build() {
  docker build \
    --tag magic:root \
    . # dot!
}

function run() {
  docker run \
    magic:root
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

function run-hosts() {
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
make TASK
./cli.sh TASK

TASKS
  build       - build magic-root dependency containers
  run         - run magic-root volume

  build-hosts - build docker containers
  run-hosts - run docker containers

  help    - this help text
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
