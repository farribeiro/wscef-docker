# wscef-docker

Warsaw in docker container

## Instructions

Use docker compose to build and run the docker container, rather than `docker run`, 
since environments and volumes are set on `docker-compose.yml`.

**To build:** `docker-compose build wscef`

**To pulling existing image:** `docker-compose pull`

**To first run:** `docker-compose run --name wscef wscef`

**To other runs:** `docker start -a wscef`

**PS:** Reports that the warsaw daemon for CEF works for the BB site. On comment:
https://github.com/farribeiro/wscef-docker/issues/9#issuecomment-308244119

**PS:** you must run Docker using a GNU/Linux distro running xorg.
Be aware some installations may run another display server, such as Wayland. 
