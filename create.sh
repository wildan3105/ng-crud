#!/bin/bash

# user
user=$(who am i | awk '{print $1}')

# Test output
echo Welcome, $user

# Dir variables
sitesEnabled='/etc/nginx/sites-enabled/'
sitesAvailable='/etc/nginx/sites-available/'
sitesDir='/var/www/'
uri='$uri'

# Input
domain=$1

# Check user privileges
if [ "$(whoami)" != 'root' ]; then
	echo $"You have no permission to run $0 as non-root user. Use sudo"
		exit 1;
fi

# Check domain
while [ "$domain" == "" ]
do
	echo -e $"Please provide domain to create. e.g.dev,staging"
	read domain
done

# CREATE
## make root directory
mkdir -p /var/www/"$domain"/html

## grant privileges
cd $sitesDir$domain
chown -R $USER:$USER html/
chmod -R 755 /var/www/"$domain"/html

echo "Domain created at : " $domain

## make index.html file
touch /var/www/"$domain"/html/index.html
echo "This is my domain : " $domain >> /var/www/"$domain"/html/index.html

## create config file
echo "
server {
	listen 80;
	listen [::]:80;

	root $sitesDir$domain/html;
	index index.html index.htm;

	# Make site accessible from http://localhost/
	server_name $domain www.$domain;

	location / {
		try_files $uri $uri/ =404;
	}
}
" >> /etc/nginx/sites-available/"$domain"

## enable block
ln -s $sitesAvailable$domain $sitesEnabled

## restart nginx
service nginx restart

## VOILA!
echo 'Congrats! Your domain is now online at : '$domain 'or at : www.'$domain
