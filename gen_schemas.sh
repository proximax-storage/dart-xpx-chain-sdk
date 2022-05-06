#!/bin/bash
set -eu

schemasdir=$(pwd)/schemas
sampledir=$(cd $(dirname $BASH_SOURCE) && pwd)
rootdir=$(cd $schemasdir/ && pwd)
cd $schemasdir/
currentdir=$(pwd)

if [[ "$schemasdir" != "$currentdir" ]]; then
  echo Error: This script must be run from inside the $schemas directory.
  echo You executed it from the $schemas directory.
  exit 1
fi

# Run `flatc`. Note: This requires you to compile using `cmake` from the
# root `/flatbuffers` directory.
if [ -e /usr/local/bin/flatc ]; then
  flatc --no-warnings --gen-all --dart -o ../lib/imp/buffer/ --schema *.fbs
else
  echo 'flatc' could not be found. Make sure to build FlatBuffers from the \
       $rootdir directory.
  exit 1
fi