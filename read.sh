#!/bin/bash

# user
user=$(who am i | awk '{print $1}')

# static variables
sitesEnabled='/etc/nginx/sites-enabled/'
sitesAvailable='/etc/nginx/sites-available/'
sitesDir='/var/www/'

# get all directory with dot (.)
ls=$(ls $sitesAvailable | grep \\.)

if [ -z $ls ]; then
  echo "$(tput setaf 1) Sorry, no domains available$(tput sgr 0)"
else
  echo "$(tput setaf 2)This is domain list :$(tput sgr 0)"
  echo $ls
fi
