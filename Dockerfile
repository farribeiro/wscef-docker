# Run Warsaw in a container

# First run:
#
# docker run -it \
#	--net host \ # may as well YOLO
#	--cpuset-cpus 0 \ # control the cpu
#	--memory 512mb \ # max memory it can use
#	-v /tmp/.X11-unix:/tmp/.X11-unix \ # mount the X11 socket
#	-e DISPLAY=unix$DISPLAY \
#	--device /dev/snd \ # so we have sound
#	-v /dev/shm:/dev/shm \
#	--name ws-cef \
#	farribeiro/ws-cef
#
# Other run:
#
# docker start ws-cef

# Base docker image
FROM ubuntu
LABEL maintainer "Fabio Rodrigues Ribeiro <farribeiro@gmail.com>>"

# Install Firefox
RUN apt-get update && apt-get upgrade -y \
	&& apt-get install -y \
	openssl \
	libnss3-tools \
	firefox \
	firefox-locale-pt \
	--no-install-recommends
	# firefox -CreateProfile default
	&& apt-get purge --auto-remove -y \
	&& rm -rf /var/lib/apt/lists/* \
	&& rm -rf /src/*.deb

# Add ff  user
RUN groupadd -r ff && useradd -r -g ff -G audio,video ff \
    && mkdir -p /home/ff \
    && chown -R ff:ff /home/ff

ADD https://cloud.gastecnologia.com.br/cef/warsaw/install/GBPCEFwr64.deb /src/GBPCEFwr64.deb

# ENTRYPOINT ["/etc/init.d/warsaw start"]
COPY local.conf /etc/fonts/local.conf

# Run firefox as non privileged user
USER ff

# Autorun chrome
# ENTRYPOINT [ "/usr/local/bin/warsaw/core && firefox" ]
# CMD [ "-private-window http://www.caixa.gov.br/" ]
