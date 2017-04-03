#!/bin/bash

su -c "apt-get update \
  && apt-get upgrade -y"

if [ ! -d $HOME/.mozilla ]
then
  firefox -CreateProfile default \
  && su -c "apt -y install /src/GBPCEFwr64.deb" \
  && exit 3
else
  su -c "/etc/init.d/warsaw start" \
  && /usr/local/bin/warsaw/core \
  && firefox -private-window www.caixa.gov.br
fi
