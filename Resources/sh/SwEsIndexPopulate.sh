#!/bin/bash

cd $1

if [ $2 ]
  then
    php bin/console sw:es:index:populate --shopId $2
  else
    php bin/console sw:es:index:populate
fi