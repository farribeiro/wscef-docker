# wscef-docker

[![Join the chat at https://gitter.im/farribeiro/wscef-docker](https://badges.gitter.im/farribeiro/wscef-docker.svg)](https://gitter.im/farribeiro/wscef-docker?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

Warsaw in docker container. Warsaw is a security module, a.k.a Guardião, for brazilian
internet banking. This project is compatible of Banco do Brasil, Caixa Econômica
Federal and Sicredi.

## Pre-requisites

- Docker and Docker-Compose of your distro.
- Set BANKFILES variable (as `export BANKFILES=/home/ff/Downloads/Bankfiles`) to prevent volume creation error
- For transparency, privacy and security NEVER USE ANY PRE-BUILT DOCKER IMAGE FROM THIS PROJECT.
- Obtain a copy of the source code of this repository, check the content and build your own image.

## Instructions

Use docker compose to build and run the docker container, rather than `docker run`, 
since environments and volumes are set on `docker-compose.yml`.

**To build:** `docker-compose build wscef`

**To first run:** `docker-compose run --name wscef wscef`

**To other runs:** `docker start -i -a wscef`

**To purge everthing:** `docker-compose down --rmi all`, thanks[1]

**To force replace the container:** `docker-compose up --force-recreate`, thanks[1]

**PS:** Reports that the warsaw daemon for CEF works for:
- BB site: https://github.com/farribeiro/wscef-docker/issues/9#issuecomment-308244119 
- Sicredi ( https://github.com/farribeiro/wscef-docker/pull/72#issuecomment-573244722)

~~**PS:** you must run Docker using a GNU/Linux distro running xorg.
Be aware some installations may run another display server, such as Wayland.~~

The latest firefox release support wayland, not tested with xauth

[1] https://github.com/jsalatiel/wsbb-docker/commit/72e42bb5f04fbe8eb1f7f3e6226975aba137dcb5#diff-3254677a7917c6c01f55212f86c57fbf
