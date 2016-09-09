#!/bin/sh

cd $(dirname "$0")

rm -fr .git

git init .
git add .
git rm -r --cached ./raw
git commit -m 'Reset repository, adding only script files'
git log
