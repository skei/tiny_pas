#!/bin/bash

echo
echo --------------------------------------------------
echo compiling system.pas
echo --------------------------------------------------
echo

# fpc -Os -Us -a -XX -CX system
fpc -O4s -Us -al -XXs -CXn system

echo
echo --------------------------------------------------
echo compiling fpintres.pas
echo --------------------------------------------------
echo

# fpc -Os -a -XX -CX fpintres
fpc -O4s -al -XXs -CXn fpintres

echo
echo --------------------------------------------------
echo compiling sysinitpas.pas
echo --------------------------------------------------
echo

# fpc -Os -a -XX -CX sysinitpas
fpc -O4s -al -XXs -CXn sysinitpas

echo
echo --------------------------------------------------
echo


