# A Simple Deployment Docker Lab
Another example of deploying a simple **Ruby Sinatra** application, but this time using **Docker**.

## Base image
- ubuntu:14.10

Only becuase I prefer the *Debian/Ubuntu* way.

## Key packages
### nginx
This is used to again protect our application by introduction a forward proxy layer.

### ruby2.0
Because we are deploying a **Sinatra** (Ruby) application.

### opensshserver
To enable the download and install of **Ruby** gems, we need Open SSH. For any derived Docker images, this can be used to improve even further the application by introducing HTTPS.

### bundler (gem)
Installed for perform the Sinatra application ```bundle install``` and ```bundle exec``` commands.

## Other files
### Script: /usr/bin/simple-deployment
This script is used to firstly start the *Sinatra* application using ```bundle exec rackup``` and then start **nginx** as the daemon feature of nginx has been turned off as we do not want this attribute enable under **Docker**. 

### Conf: /etc/nginx/site-available/default
This configuration file is over written with our template file **files/simple-deployment.conf** to set the behaviour of the **nginx** default site.

### File: /var/www/simple-deployment
For now, the simple Sinatra application files are included as part of this solution. The next challenge will be download the application files from GitHub at https://github.com/tnh/simple-sinatra-app where these site files have been derived from.

## Docker
### Configuration
Other attributes of this Docker solution are:
- That port ```80``` is exposed.
- The file **/usr/bin/simple-deployment** is made executable.
- The ```bundle install``` is run as part of the build.
- And finally, the ```CMD``` used is ```/usr/bin/simple-deployment```

### Building
To build this image, it is a simple matter of running:

```bash
sudo docker build --tag="simple-deployment:0.2" .
```
Always good to increment the tag part ```0.2``` of the repository tag name.

### Running
To create and run a container using your new image, execute:

```bash
sudo docker run -d --name="simple-deployment" --restart=always -p=8090:80 simple-deployment:0.2
```
Change the host port ```8090``` to one you prefer. Again, depending on the build you wish to use, change the build tag ```0.2``` to the one you wish to use.

To stop your container, execute:

```bash
sudo docker stop simple-deployment
```

If you do need to restart the container, execute:
```bash
sudo docker start simple-deployment
```

And once your finished and no longer need the container, remove it by executing:
```bash
sudo docker rm simple-deployment
```
