#!/bin/bash

echo
echo --------------------------------------------------
echo compiling intro.pas
echo --------------------------------------------------
echo

# fpc -Os -a -XX -CX intro
fpc -O4s -al -XXs -CXn -Tlinux intro

echo
echo --------------------------------------------------
echo

