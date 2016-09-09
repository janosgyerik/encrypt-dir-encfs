#!/bin/sh

type encfs >/dev/null 2>/dev/null || {
    echo Error: The program "'encfs'" is either not installed or cannot be found in PATH.
    exit 1
}

cd $(dirname "$0")

mkdir -p ./content

encfs -i 5 $PWD/raw $PWD/content
