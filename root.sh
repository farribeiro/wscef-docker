#!/bin/bash

/etc/init.d/warsaw start

# Run Firefox as non privileged user
setpriv --reuid=ff --regid=ff --init-groups --inh-caps=-all --reset-env env DISPLAY=$DISPLAY LANG=$LANG TZ=$TZ startup.sh
