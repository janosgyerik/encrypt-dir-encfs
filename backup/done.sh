#!/bin/sh

cd $(dirname "$0")

. ./common.sh || exit 1

if test -d $content -a ! -f $content.tar.gz; then
    warn There is a directory $content but no $content.tar.gz file.
    warn If you delete $content now it will be gone forever.
    warn Perhaps you want to run ./encrypt.sh instead.
    exit 1
fi

rm -fr $content
