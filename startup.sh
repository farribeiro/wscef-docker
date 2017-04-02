if [ ! -d ${Home}/.mozilla ]
then
  firefox \&&
  sleep 10 \&&
  # killall firefox \&&
  firefox -CreateProfile default \&&
  apt -y install /src/GBPCEFwr64.deb
else
  su - /etc/ \&&
  /usr/local/bin/warsaw/core \&&
  firefox
fi
