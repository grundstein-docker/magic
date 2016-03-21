.PHONY: \
	all \
	build \
	help

# TASKS

all: help

build:
	@./cli.sh build

run:
	@./cli.sh run

ips:
	@./cli.sh ips

# help output
help:
	@echo "\
Usage \n\
make TASK\n\
\n\
TASKS \n\
	build   - build docker containers \n\
	run     - run docker containers \n\
\n\
	help    - this help text \n\
"
