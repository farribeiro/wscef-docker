# wscef-docker

[![Join the chat at https://gitter.im/wscef-docker/community](https://badges.gitter.im/wscef-docker/community.svg)](https://gitter.im/wscef-docker/community?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

Warsaw in docker container. Warsaw is a security module, a.k.a Guardião, for brazilian
internet banking. This project is compatible of Banco do Brasil and Caixa Econômica
Federal.

## Pre-requisites

- Docker and Docker-Compose of your distro.

## Instructions

Use docker compose to build and run the docker container, rather than `docker run`, 
since environments and volumes are set on `docker-compose.yml`.

**To build:** `docker-compose build wscef`

**To pulling existing image:** `docker-compose pull`

**To first run:** `docker-compose run --name wscef wscef`

**To other runs:** `docker start -i -a wscef`

**To purge everthing:** `docker-compose down --rmi all`, thanks[1]

**To force replace the container:** `docker-compose up --force-recreate`, thanks[1]

**PS:** Reports that the warsaw daemon for CEF works for the BB site:
https://github.com/farribeiro/wscef-docker/issues/9#issuecomment-308244119

**PS:** you must run Docker using a GNU/Linux distro running xorg.
Be aware some installations may run another display server, such as Wayland. 

**PS:** The root password is **wscef** by https://github.com/farribeiro/wscef-docker/issues/29

[1] https://github.com/jsalatiel/wsbb-docker/commit/72e42bb5f04fbe8eb1f7f3e6226975aba137dcb5#diff-3254677a7917c6c01f55212f86c57fbf
