# Run Warsaw in a container

# Base docker image
FROM debian:stretch-slim
LABEL maintainer "Fabio Rodrigues Ribeiro <farribeiro@gmail.com>"

ENV USER=ff
ENV GUID=1000

# Setup locale
RUN apt-get update && apt-get install -y locales \
	&& localedef -i pt_BR -c -f UTF-8 -A /usr/share/locale/locale.alias pt_BR.UTF-8

# Install Firefox
RUN apt-get upgrade -y \
	&& apt-get install -y \
	ca-certificates \
	wget \
	--no-install-recommends \
	&& mkdir -p /src \
	&& wget https://cloud.gastecnologia.com.br/gas/diagnostico/warsaw_setup_64.deb -O /src/GBPCEFwr64.deb
RUN apt-get install -y \
	firefox-esr \
	firefox-esr-l10n-pt-br \
	libc6 \
	# libcurl4 \
	libdbus-1-3 \
	libgcc1 \
	libgdk-pixbuf2.0-0 \
	libglib2.0-0 \
	libgtk2.0-0 \
	libnss3-tools \
	libpango-1.0-0 \
	libpython2.7-minimal \
	libpython2.7-stdlib \
	# libssl1.0.0 \
	libstdc++6 \
	libx11-6 \
	libxi6 \
	openssl \
	procps \
	python-gpg \
	python-openssl \
	python2.7 \
	sed \
	sudo \
	xauth \
	zenity \
	--no-install-recommends \
	&& mkdir -p /home/${USER} \
	&& groupadd -g ${GUID} -r ${USER} \
	&& useradd -u ${GUID} -r -g ${USER} -G audio,video ${USER} -d /home/${USER} \
	&& chown -R ${GUID}:${GUID} /home/${USER} \
	&& echo 'ff ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers \
	&& echo 'Defaults !requiretty' >> /etc/sudoers \
	&& echo root:wscef | chpasswd \
	&& apt-get remove -y wget \
	&& apt-get purge --auto-remove -y \
	&& rm -rf /var/lib/apt/lists/*

# Run Firefox as non privileged user
USER ff

# Add volume for recipes PDFs
VOLUME "/home/ff/Downloads"

COPY startup.sh /home/ff/
RUN chmod 744 /home/ff/startup.sh \

# Autorun Firefox
CMD [ "/home/ff/startup.sh" ]
