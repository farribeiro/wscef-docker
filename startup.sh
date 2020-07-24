#!/bin/bash

runx() {
    XAUTHORITY=/tmp/auth "$@"
}

cp /tmp/.docker.xauth /tmp/auth
runx xauth add ${HOSTNAME}/unix${DISPLAY} . $(runx xauth list | awk '$1 !~ /localhost/ {print $3; exit}')
runx xauth generate $DISPLAY . untrusted timeout 0

/usr/local/bin/warsaw/core \
&& runx firefox -no-remote -private-window --class CaixaEconomica --name CaixaEconomica https://www.caixa.gov.br
