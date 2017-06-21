<h1>wscef-docker</h1>

<p>Warsaw in docker container</p>

<h2>Instructions</h2>

<p>Use docker compose to build and run the docker container, rather than <code>docker run</code>, 
since environments and volumes are set on <code>docker-compose.yml</code>. 

<p><strong>To build:</strong> <code>docker-compose build wscef</code></p>

<p><strong>To run:</strong> <code>docker-compose run --rm wscef</code>

<p><strong>PS:</strong> The xauth will broke the container if you restart or
poweroff the system, else in the same session will run ok, and not erase
it.</p>

<p><strong>PS2:</strong> you must run Docker using a GNU/Linux distro running xorg.
Be aware some installations may run another display server, such as Wayland. 
