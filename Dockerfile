##################################################
#
#	Simple-Deployment Lab
#
#	Version: 0.2
#
##################################################

FROM	ubuntu:14.10
MAINTAINER	Andrew Hendley <ahendley@internode.on.net>

RUN		apt-get update && apt-get install -y nginx openssh-server ruby2.0
RUN		gem install bundler
RUN 	echo "daemon off;" >> /etc/nginx/nginx.conf

ADD		./files/simple-deployment /usr/bin/
ADD		./files/www/ /var/www/simple-deployment/
ADD		./files/simple-deployment.conf /etc/nginx/sites-available/default

RUN		chmod 775 /usr/bin/simple-deployment

WORKDIR	/var/www/simple-deployment

RUN		bundle install

VOLUME	/var/log

EXPOSE 	80

CMD 	["/usr/bin/simple-deployment"]
