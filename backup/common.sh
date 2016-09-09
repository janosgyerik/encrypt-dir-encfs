#!/bin/sh

# the directory with the content to encrypt
content=./content

msg() {
    echo '* '"$@"
}

warn() {
    msg WARNING: "$@"
}
