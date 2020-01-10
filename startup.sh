#!/bin/bash

if [ -n "${XAUTHORITY}" ] && [ -n "${HOST_HOSTNAME}" ]
then
  if [ "${HOSTNAME}" != "${HOST_HOSTNAME}" ]
  then
    [ -f ${XAUTHORITY} ] || touch ${XAUTHORITY}
    xauth add ${HOSTNAME}/unix${DISPLAY} . \
    $(xauth -f /tmp/.docker.xauth list ${HOST_HOSTNAME}/unix${DISPLAY} | awk '{ print $NF }')
  else
    cp /tmp/.docker.xauth ${XAUTHORITY}
  fi
fi

if [ ! -d ~/.mozilla ]
then
  # sudo dbus-uuidgen > /etc/machine-id \
  firefox -no-remote -CreateProfile default # \
  # && sudo apt update \
  # && sudo apt -y upgrade \
  # && sudo apt -y install /src/GBPCEFwr64.deb
#else
  # sudo /etc/init.d/warsaw start
fi
sudo /etc/init.d/warsaw start

/usr/local/bin/warsaw/core \
&& firefox -no-remote -private-window --class CaixaEconomica --name CaixaEconomica https://www.caixa.gov.br
