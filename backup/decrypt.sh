#!/bin/sh

cd $(dirname "$0")

. ./common.sh || exit 1

test -f $content.tar.gz || exit 1

msg decrypting $content.tar.gz ...
umask 0077
openssl des3 -d < $content.tar.gz | gzip -cd | tar x

msg fixing permissions ...
chmod -R g-rwx $content

cat << EOF

!!! IMPORTANT !!!

As soon as you are done editing $content/, run ./encrypt.sh to create
the encrypted $content.tar.gz again. This will remove $content/ itself.

If you did not make any changes, simply run ./done.sh or rm -fr $content

EOF
