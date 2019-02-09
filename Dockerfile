# Run Warsaw in a container

# Base docker image
FROM debian:stretch-slim
LABEL maintainer "Fabio Rodrigues Ribeiro <farribeiro@gmail.com>"

ENV USER=ff
ENV GUID=1000

ENV LANG=pt_BR.UTF-8

COPY startup.sh /home/ff/

RUN apt-get update && \
	apt-get install -y --no-install-recommends \
		locales \
		ca-certificates \
		wget \
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
	# Setup locale
	&& echo "pt_BR.UTF-8 UTF-8" > /etc/locale.gen \
	&& locale-gen \
	# Downloading warsaw
	&& mkdir -p /src \
	&& wget https://cloud.gastecnologia.com.br/gas/diagnostico/warsaw_setup_64.deb -O /src/GBPCEFwr64.deb \
	# Configuring the environment
	&& mkdir -p /home/${USER} \
	&& chmod 744 /home/ff/startup.sh \
	&& groupadd -g ${GUID} -r ${USER} \
	&& useradd -u ${GUID} -r -g ${USER} -G audio,video ${USER} -d /home/${USER} \
	&& chown -R ${GUID}:${GUID} /home/${USER} \
	&& echo 'ff ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers \
	&& echo 'Defaults !requiretty' >> /etc/sudoers \
	&& echo root:wscef | chpasswd \
	# Cleanup
	&& apt remove --purge -y wget \
	&& apt autoremove -y \
	&& apt clean \
	&& rm -rf /var/lib/apt/lists/* /var/cache/apt/*

# Run Firefox as non privileged user
USER ff

# Add volume for recipes PDFs
VOLUME "/home/ff/Downloads"

# Autorun Firefox
CMD /home/ff/startup.sh
