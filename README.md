# docker-puppet
Docker container with Puppet inside

Following James Turnbull’s article here:
https://puppetlabs.com/blog/building-puppet-based-applications-inside-docker

To use this image we look at an implementation example:
https://github.com/joshuacox/docker-puppet-nginx

You need to create a Puppetfile file which Librarian-Puppet uses to install the required Puppet modules. As our example we’re going to install a basic Nginx server.
```
mod "nginx",
       :git => "https://github.com/jfryman/puppet-nginx"
```
The Puppetfile tells Librarian-Puppet to install the puppet-nginx module from GitHub.

Now you need to create another Dockerfile for your application image.
```
FROM joshuacox/docker-puppet
MAINTAINER “yourself yourself@example.com”

ADD Puppetfile /
RUN librarian-puppet install
RUN puppet apply --modulepath=/modules -e "class { 'nginx': }"
RUN echo "daemon off;" >> /etc/nginx/nginx.conf
EXPOSE 80
CMD ["nginx"]
```
This Dockerfile uses the image from this repo, Then it adds our local Puppetfile file to the root of the image and then runs librarian-puppet install to install our required modules (by default into /modules).

We then install Nginx via the puppet-nginx module using the puppet apply command. This runs Puppet locally on the host (i.e. without a client-server Puppet installation).

In this image we’re just installing Nginx itself. We could also install virtual hosts or a web application or anything else that the Nginx module supports.

We can now build our application image like so:
```
$ sudo docker build -t="jamtur01/nginx" .
```
Finally let’s launch a container from it.
```
$ sudo docker run -P -d jamtur01/nginx
fd461a1418c6
```
We’ve launched a new container with the ID of fd461a1418c6, run it daemonized and told it to open any exposed ports, in our case port 80 that we EXPOSE‘ed in the Dockerfile. Let’s check the container and see what port it has mapped to Nginx.
```
 $ sudo docker port fd461a1418c6 80
 0.0.0.0:49158
```
Now let’s browse to port 49158 to see if Nginx is running.
