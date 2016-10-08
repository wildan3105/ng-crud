#!/bin/bash

# user
user=$(who am i | awk '{print $1}')

# Test output
echo Welcome, $user

# Dir variables
sitesEnabled='/etc/nginx/sites-enabled/'
sitesAvailable='/etc/nginx/sites-available/'
sitesDir='/var/www/'

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
	echo -e $"Please provide domain to delete. e.g.dev,staging"
	read domain
done

# DELETE
## remove root directory
rm -rf /var/www/"$domain"/html

## remove index.html file
rm /var/www/"$domain"/html/index.html

## remove config file
rm $sitesAvailable$domain

## remove block
rm $sitesEnabled$domain

## restart nginx
service nginx restart

## VOILA!
echo 'Domain has been successfully demolished'

