#!/bin/sh

cd $(dirname "$0")

./umount.sh

git add ./raw
git commit -m _
git push
