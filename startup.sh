#!/bin/bash

if [ ! -d ${Home}/.mozilla ]
then
  firefox -CreateProfile default \&&
  apt -y install /src/GBPCEFwr64.deb
else
  su - /etc/ \&&
  /usr/local/bin/warsaw/core \&&
  firefox
fi
