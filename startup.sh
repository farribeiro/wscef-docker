#!/bin/bash

if [ ! -d ${Home}/.mozilla ]
then
  firefox -CreateProfile default \
  && su -c "apt -y install /src/GBPCEFwr64.deb"
else
  su -c "/etc/init.d/warsaw start" \
  && /usr/local/bin/warsaw/core \
  && firefox
fi
