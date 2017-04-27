# Run Warsaw in a container

# Base docker image
FROM ubuntu:latest
LABEL maintainer "Fabio Rodrigues Ribeiro <farribeiro@gmail.com>"

# Install Firefox

ADD	\
	# https://s3-sa-east-1.amazonaws.com/shared-www.validcertificadora.com.br/libjbig0_2.0-2_amd64.deb \
	https://s3-sa-east-1.amazonaws.com/shared-www.validcertificadora.com.br/libtiff4_3.9.6-6ubuntu1_amd64.deb \
	# https://s3-sa-east-1.amazonaws.com/shared-www.validcertificadora.com.br/fontconfig-config_2.9.0-7_all.deb \
	# https://s3-sa-east-1.amazonaws.com/shared-www.validcertificadora.com.br/libfontconfig1_2.9.0-7_amd64.deb \
	https://s3-sa-east-1.amazonaws.com/shared-www.validcertificadora.com.br/libwxbase2.8-0_2.8.12.1-6ubuntu2_amd64.deb \
	https://s3-sa-east-1.amazonaws.com/shared-www.validcertificadora.com.br/libwxgtk2.8-0_2.8.12.1-6ubuntu2_amd64.deb \
	# https://s3-sa-east-1.amazonaws.com/shared-www.validcertificadora.com.br/libpcsclite1_1.8.5-1ubuntu1_amd64.deb \
	# https://s3-sa-east-1.amazonaws.com/shared-www.validcertificadora.com.br/libccid_1.4.7-1_amd64.deb \
	http://www.iti.gov.br/images/middlewares/safesignidentityclient_3.0.77-Ubuntu_amd64.deb \
	/src/

RUN apt-get update \
	&& apt-get upgrade -y \
	&& apt-get install -y \
	language-pack-pt \
	openssl \
	libnss3-tools \
	firefox \
	firefox-locale-pt \
	xauth \
	opensc \
	libopensc-openssl \
	pcscd \
	pcsc-tools \
	--no-install-recommends \
	&& apt -y install /src/*.deb \
	&& apt-get purge --auto-remove -y \
	&& rm -rf /var/lib/apt/lists/* \
	&& rm -rf /src/*.deb

ADD https://cloud.gastecnologia.com.br/cef/warsaw/install/GBPCEFwr64.deb /src/
COPY startup.sh /home/ff/

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
