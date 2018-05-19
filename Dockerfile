# Run Warsaw in a container

# Base docker image
FROM ubuntu:latest
LABEL maintainer "Fabio Rodrigues Ribeiro <farribeiro@gmail.com>"

ADD https://cloud.gastecnologia.com.br/cef/warsaw/install/GBPCEFwr64.deb /src/
COPY startup.sh /home/ff/

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
	sed \
	libdbus-1-3 \
	procps \
	python2.7 \
	libpython2.7-minimal \
	libpython2.7-stdlib \
	python-gpg \
	python-openssl \
	zenity \
	libc6 \
	libcurl4 \
	libgtk2.0-0 \
	libgdk-pixbuf2.0-0 \
	libpango-1.0-0 \
	libglib2.0-0 \
	libx11-6 \
	libstdc++6 \
	libgcc1 \
	libssl1.0.0 \
	libxi6 \
	--no-install-recommends \
	&& groupadd -g 1000 -r ff \
	&& useradd -u 1000 -r -g ff -G audio,video ff -d /home/ff \
	&& chmod 744 /home/ff/startup.sh \
	&& chown -R ff:ff /home/ff \
	&& echo root:wscef | chpasswd \
	&& apt-get purge --auto-remove -y \
	&& rm -rf /var/lib/apt/lists/*

# Run firefox as non privileged user
USER ff

# Add volume for recipes PDFs
VOLUME "/home/ff/Downloads"

# Autorun chrome
CMD [ "/home/ff/startup.sh" ]
