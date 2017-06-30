# Run Warsaw in a container

# Base docker image
FROM alpine:latest
LABEL maintainer "Fabio Rodrigues Ribeiro <farribeiro@gmail.com>"

COPY startup.sh /home/ff/

# Install Firefox
RUN apk -U update \
	&& apk -U add \
	openssl \
	firefox-esr \
	xauth \
	--no-install-recommends \
	&& groupadd -g 1000 -r ff \
	&& useradd -u 1000 -r -g ff -G audio,video ff -d /home/ff \
	&& chmod 744 /home/ff/startup.sh \
	&& chown -R ff:ff /home/ff \
	&& passwd -d root \
	&& apt-get purge --auto-remove -y \
	&& rm -rf /var/lib/apt/lists/*

# Run firefox as non privileged user
USER ff

# Add volume for recipes PDFs
VOLUME "/home/ff/Downloads"

# Autorun chrome
CMD [ "/home/ff/startup.sh" ]
