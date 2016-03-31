CLI=./cli.sh

.PHONY: \
	all \
	build \
	run \
	build-hosts \
	run-hosts \
	ips \
	update \
	status \
	help

# TASKS

all: help

build:
	@${CLI} $@

build-hosts:
	@${CLI} $@

run:
	@${CLI} $@

run-hosts: run

ips:
	@${CLI} $@

update:
	@${CLI} $@

status:
	@${CLI} $@

# help output
help:
	@${CLI} $@

test-loop:
	@${CLI} $@
