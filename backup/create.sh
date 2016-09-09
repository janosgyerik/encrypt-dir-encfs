#!/bin/sh

cd $(dirname "$0")

. ./common.sh || exit 1

../mount.sh || exit 1

umask 0077
mkdir -p $content
cp -r ../content/* $content/

./encrypt.sh
