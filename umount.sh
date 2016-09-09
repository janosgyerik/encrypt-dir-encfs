#!/bin/sh

cd $(dirname "$0")

if test "$(uname)" = Darwin; then
    umount ./content
else
    fusermount -u ./content
fi

rmdir ./content
