# Nginx Virtual Host CRUD Operation

Simple bash script to perform CRUD (Create, Read, Update, and Delete) virtual host using Nginx

## Installation
1. Download the codes via terminal on your server

  `$ wget https://github.com/wldn/Nginx-Vhost-CRUD-Operation/archive/master.zip`

2. Unzip the codes

  `$ unzip master.zip /path/to`
  
3. Change permission for all files

  `$ chmod +x *.sh`
  
4. Start managing your Nginx virtual host and **be productive** !

5. **Optional** : If you wanna edit the script on your own, you can also change permission to 755 to enable editing

  `$ chmod 755 *.sh`
  
## Usage

![](http://i.giphy.com/bmJBov60DXOvu.gif)

**Assumption(s)** : You have set your basic Nginx virtual host / server blocks. If you haven't set it yet, check to this link : 

[How to set up nginx virtual host on Ubuntu 16.04](https://www.digitalocean.com/community/tutorials/how-to-set-up-nginx-server-blocks-virtual-hosts-on-ubuntu-16-04)

Basic command line syntax :
  `$ sudo ./create.sh [argument]`

## Examples
1. Create a new virtual host : 
   
   *Syntax* : `$ sudo ./create.sh [domain]`

   **Example** : `$ sudo ./create.sh blog.wildan.us`

2. List all active virtual host(s): 
   
   *Syntax* : `$ ./read.sh`

   **Example** : `$ ./read.sh`

3. Delete certain virtual host : 
   
   *Syntax* : `$ sudo ./delete.sh [domain]`

   **Example** : `$ sudo ./delete.sh blog.wildan.us`

4. Update virtual host address : 
   
   *Syntax* : `$ sudo ./update.sh [old-domain] [new-domain]`

   **Example** : `$ sudo ./update.sh blog.wildan.us notes.wildan.us`

## Further Development
- [ ] Add usage.sh
- [x] Check if domain already exist
- [ ] Colored output text

## License

MIT
