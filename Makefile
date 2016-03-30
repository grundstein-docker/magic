.PHONY: \
	all \
	build \
	run \
	build-hosts \
	run-hosts \
	ips \
	help

# TASKS

all: help

build:
	@./cli.sh build

build-hosts:
	@./cli.sh build-hosts

run:
	@./cli.sh run

run-hosts: run

ips:
	@./cli.sh ips

# help output
help:
	@./cli.sh help
