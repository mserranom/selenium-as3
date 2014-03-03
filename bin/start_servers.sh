#!/bin/sh

cd socketpolicy
./socketpolicy.pl > /dev/null &

cd ..
http-server  java-lib/src/test/resources/
