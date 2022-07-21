#!/bin/sh

DIRPATH=$(cd $(dirname $0); pwd)
for FILEPATH in $DIRPATH/dot.*
do
  BASENAME=$(basename $FILEPATH)
  ln -nfsv $FILEPATH $HOME/${BASENAME#dot}
done
