#!/bin/bash

# user
user=$(who am i | awk '{print $1}')

# Dir variables
sitesEnabled='/etc/nginx/sites-enabled/'
sitesAvailable='/etc/nginx/sites-available/'
sitesDir='/var/www/'

ls=$(ls $sitesAvailable | grep \\.)

if [ -z $ls ]; then
  echo "Sorry, no domains available"
else
  echo $"This is domain list : "
  echo $ls
fi
