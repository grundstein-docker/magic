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

run:
	@./cli.sh run

build-hosts:
	@./cli.sh build-hosts

run-hosts:
	@./cli.sh run-hosts

ips:
	@./cli.sh ips

# help output
help:
	@./cli.sh help
