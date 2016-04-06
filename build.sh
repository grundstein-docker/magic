#!/usr/bin/env bash

echo "STARTING: build nodejs"

mkdir -p $DIST_DIR

$NODE_BIN/babel \
  --out-dir $DIST_DIR \
  $NODEJS_SRC_FILES

echo "FINISHED: building nodejs"

echo "STARTING: copy express views and public dir"

cp -r \
  $CLIENT_SRC_FILES \
  $DIST_DIR/client

echo "FINISHED: copying express views and public dir"
