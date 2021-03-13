<h1> Issabel PBX</h1>

Issabel for Docker in centos 7  (development - not production)

<h2>Install</h2>


<pre><code>$ docker run --privileged --restart=always --name issabel -v /sys/fs/cgroup:/sys/fs/cgroup:ro -dti --hostname pbx  deathmetall/issabel:latest
$ docker exec -it issabel ./install.sh
</code></pre>
This process is necessary to install issabel within the centos image with systemd, after the installation we create a new image from it with our pbx configured. 

This image is designed to be used as a host leaving available ports 80 and 443 which I am using with Traefik, port 80 and 443 are still exposed in the image.
<pre><code>$ docker commit issabel deathmetall/issabel:live
$ docker rm -f issabel
</code></pre>

<h2> Run</h2>
<pre><code>
$ docker run --restart=always --name issabel \
        --privileged -v /sys/fs/cgroup:/sys/fs/cgroup:ro \
        -v issabel-etc:/etc -v issabel-data:/var/lib \
        -dti --hostname pbx.saiyans.com.ve --network host \
       deathmetall/issabel:live
</code></pre>

### docker-compose.yml 

This compose is designed to be used as a host leaving available ports 80 and 443
<pre><code>
$ git clone https://github.com/tomasmetal23/Issabel.git
</code></pre>
to configure the apache ports edit the ssl.conf and httpd.conf files that were downloaded from the repository. 
<pre><code>
$ docker-compose up -d
</code></pre>
![Done](https://i.imgur.com/1lZEjNf.png)

<h2>Notes</h2>
I think that an optimal image for production should have each service separated into another image, example: apache/issabel, mysql/issabel.

https://blog.saiyans.com.ve/2020/09/25/pbx-issabel-despliegue-con-docker/

https://hub.docker.com/repository/docker/deathmetall/issabel
