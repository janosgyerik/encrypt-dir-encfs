#!/bin/sh

cd $(dirname "$0")

. ./common.sh || exit 1

test -d $content || exit 1

test -f $content.tar.gz || > $content.tar.gz
chmod go-rwx $content.tar.gz

msg encrypting directory: $content
tar zc $content | openssl des3 > $content.tar.gz && rm -fr $content

msg done
ls -l $content.tar.gz
