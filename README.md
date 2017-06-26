<h1>wscef-docker</h1>

<p>Warsaw in docker container</p>

<h2>Instructions</h2>

<p>Use docker compose to build and run the docker container, rather than <code>docker run</code>, 
since environments and volumes are set on <code>docker-compose.yml</code>. 

<p><strong>To build:</strong> <code>docker-compose build wscef</code></p>

<p><strong>To run:</strong> <code>docker-compose run --rm wscef</code>

<p><strong>PS:</strong> Xauth will break the container if you restart or
shut down the system. So at each new session, you must instantiate a new container.</p>

<p><strong>PS2:</strong> you must run Docker using a GNU/Linux distro running xorg.
Be aware some installations may run another display server, such as Wayland. 
