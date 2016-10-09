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
oldDomain=$1
newDomain=$2

# Check user privileges
if [ "$(whoami)" != 'root' ]; then
	echo $"You have no permission to run $0 as non-root user. Use sudo"
		exit 1;
fi

# Check domain
while [ "$oldDomain" == "" ] && [ "$newDomain" == "" ]
do
	echo -e $"Please provide domain names with the following format :  "
  echo "Format : ./update.sh [old domain] [new domain]"
	read oldDomain newDomain
done

# DELETE FIRST
## remove old root directory
rm -rf /var/www/"$oldDomain"/html

## remove entire directory
rmdir /var/www/"$oldDomain"

## remove old config file
rm $sitesAvailable$oldDomain

## remove old block
rm $sitesEnabled$oldDomain

echo "Removing succeed. Then create..."

# THEN CREATE

## create new root directory
mkdir -p /var/www/"$newDomain"/html

## grant privileges
cd $sitesDir$newDomain
chown -R $user:$user html/
chmod -R 755 /var/www/"$newDomain"/html
echo "Domain created at : " $newDomain

## make new index.html file
touch /var/www/"$newDomain"/html/index.html
echo "This is my domain : " $newDomain >> /var/www/"$newDomain"/html/index.html

## create config file for new one
echo "
server {
	listen 80;
	listen [::]:80;

	root $sitesDir$newDomain/html;
	index index.html index.htm;

	server_name $newDomain www.$newDomain;

	location / {
			try_files $uri $uri/ =404;
	}
}
" >> /etc/nginx/sites-available/"$newDomain"

## enable new block
ln -s $sitesAvailable$newDomain $sitesEnabled

## restart nginx
service nginx restart

## VOILA!
echo 'Congrats! Your domain' $oldDomain 'has changed to' $newDomain
