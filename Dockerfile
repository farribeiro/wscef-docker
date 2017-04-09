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
#	--restart=on-failure:1
#	farribeiro/wscef-docker
#
# Other run:
#
# docker start ws-cef

# Base docker image
FROM ubuntu
LABEL maintainer "Fabio Rodrigues Ribeiro <farribeiro@gmail.com>"

# Install Firefox
RUN apt-get update \
	&& apt-get upgrade -y \
	&& apt-get install -y \
	language-pack-pt \
	openssl \
	libnss3-tools \
	firefox \
	firefox-locale-pt \
	xauth \
	--no-install-recommends \
	# firefox -CreateProfile default
	&& apt-get purge --auto-remove -y \
	&& rm -rf /var/lib/apt/lists/* \
	&& rm -rf /src/*.deb


# ADD https://cloud.gastecnologia.com.br/cef/warsaw/install/GBPCEFwr64.deb /src/GBPCEFwr64.deb
COPY startup.sh /home/ff/startup.sh

# Add ff  user
RUN groupadd -g 1000 -r ff \
    && useradd -u 1000 -r -g ff -G audio,video ff \
    && mkdir -p /home/ff \
    && chmod 744 /home/ff/startup.sh \
    && chown -R ff:ff /home/ff \
    && passwd -d root


# Run firefox as non privileged user
USER ff

# Autorun chrome
CMD [ "/home/ff/startup.sh" ]
