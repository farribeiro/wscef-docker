# Run Warsaw in a container

# Base docker image
FROM ubuntu:latest
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
	&& apt-get purge --auto-remove -y \
	&& rm -rf /var/lib/apt/lists/* \
	&& rm -rf /src/*.deb


COPY startup.sh /home/ff/

# Add ff  user
RUN groupadd -g 1000 -r ff \
	&& useradd -u 1000 -r -g ff -G audio,video ff \
	&& mkdir -p /home/ff \
	&& chmod 744 /home/ff/startup.sh \
	&& chown -R ff:ff /home/ff \
	&& passwd -d root

# Add ff profile
ADD mozilla-profile.txz /home/ff/

# Add warsaw
ADD https://cloud.gastecnologia.com.br/cef/warsaw/install/GBPCEFwr64.deb /src/
RUN apt -y install /src/GBPCEFwr64.deb \
 && rm /src/GBPCEFwr64.deb

# Run firefox as non privileged user
USER ff

# Autorun chrome
CMD [ "/home/ff/startup.sh" ]
