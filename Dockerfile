# Run Warsaw in a container
# Base docker image
FROM debian:buster-slim

LABEL maintainer "Fabio Rodrigues Ribeiro <farribeiro@gmail.com>"

ADD	\
	# https://s3-sa-east-1.amazonaws.com/shared-www.validcertificadora.com.br/libjbig0_2.0-2_amd64.deb \
	https://s3-sa-east-1.amazonaws.com/shared-www.validcertificadora.com.br/libtiff4_3.9.6-6ubuntu1_amd64.deb \
	# https://s3-sa-east-1.amazonaws.com/shared-www.validcertificadora.com.br/fontconfig-config_2.9.0-7_all.deb \
	# https://s3-sa-east-1.amazonaws.com/shared-www.validcertificadora.com.br/libfontconfig1_2.9.0-7_amd64.deb \
	https://s3-sa-east-1.amazonaws.com/shared-www.validcertificadora.com.br/libwxbase2.8-0_2.8.12.1-6ubuntu2_amd64.deb \
	https://s3-sa-east-1.amazonaws.com/shared-www.validcertificadora.com.br/libwxgtk2.8-0_2.8.12.1-6ubuntu2_amd64.deb \
	# https://s3-sa-east-1.amazonaws.com/shared-www.validcertificadora.com.br/libpcsclite1_1.8.5-1ubuntu1_amd64.deb \
	# https://s3-sa-east-1.amazonaws.com/shared-www.validcertificadora.com.br/libccid_1.4.7-1_amd64.deb \
	http://www.digitalsigncertificadora.com.br/repositorio/downloads/SafeSignIC3.0.116-x86_64-ub14-tc-admin.deb \
	/src/


# Run firefox as non privileged user
USER ff

# Add volume for recipes PDFs
ENV USER=ff

ENV GUID=1000

ENV LANG="pt_BR.UTF-8 UTF-8"

RUN apt-get update && \
	apt-get install -y --no-install-recommends \
		locales \
		tzdata \
		ca-certificates \
		firefox-esr \
		firefox-esr-l10n-pt-br \
		libnss3-tools \
		openssl \
		procps \
		python-gpg \
		python-openssl \
		python3 \
		xauth \
		zenity \
		opensc \
		libopensc-openssl \
		pcscd \
		pcsc-tools

# Setup locale
RUN echo ${LANG} > /etc/locale.gen \
	&& locale-gen

# Downloading warsaw
RUN mkdir -p /src

ADD https://cloud.gastecnologia.com.br/gas/diagnostico/warsaw_setup_64.deb /src/GBPCEFwr64.deb

# Configuring the environment
RUN mkdir -p /home/${USER} \
	&& groupadd -g ${GUID} -r ${USER} \
	&& useradd -u ${GUID} -r -g ${USER} -G audio,video ${USER} -d /home/${USER} \
	&& chown -R ${GUID}:${GUID} /home/${USER} \
	# Cleanup
	&& apt autoremove -y \
	&& apt clean

RUN apt -y install /src/GBPCEFwr64.deb || :

COPY root.sh /usr/local/bin/

COPY startup.sh /usr/local/bin/

RUN chmod 700 /usr/local/bin/root.sh \
    && chmod 755 /usr/local/bin/startup.sh

# Add volume for receipts PDFs
VOLUME "/home/ff/Downloads"

# Autorun Firefox
ENTRYPOINT /usr/local/bin/root.sh
