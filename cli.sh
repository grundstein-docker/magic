#!/usr/bin/env bash

source ../bin/tasks.sh

HOSTS_DIR=hosts

function build() {
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
  echo "Container: $CONTAINER_NAME"
  echo ""
  echo "Usage:"
  echo ""
  echo './cli.sh $command'
  echo ""
  echo "commands:"
  echo "build  - build docker container"
  echo "run    - run docker container"
  echo "remove - remove container"
  echo "logs   - tail the container logs"
  echo "debug  - connect to container debug session"
  echo "stop   - stop container"
  echo "help   - this help text"
}

if [ $1 ]
then
  function=$1
  shift
  $function $@
else
  help $@
fi
