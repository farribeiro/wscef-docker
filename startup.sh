#!/bin/bash

export LANG="pt_BR.UTF-8"

if [ ! -d ~/.mozilla ]
then
  firefox -CreateProfile default \
  && su -c "apt update && apt -y upgrade && apt -y install /src/GBPCEFwr64.deb"
else
  su -c "/etc/init.d/warsaw start"
fi

/usr/local/bin/warsaw/core \
&& firefox -private-window www.caixa.gov.br
