# wscef-docker

Warsaw in docker container

## Instructions

Use docker compose to build and run the docker container, rather than <code>docker run</code>, 
since environments and volumes are set on <code>docker-compose.yml.

**To build:** `docker-compose build wscef`

**To pulling existing image:** `docker-compose pull`

**To first run:** `docker-compose run --name wscef wscef`

**To other runs:** `docker start -a wscef`

**PS:** Xauth will break the container if you restart or
shut down the system. So at each new session, you must instantiate a new container.</p>

**PS2:** you must run Docker using a GNU/Linux distro running xorg.
Be aware some installations may run another display server, such as Wayland. 
