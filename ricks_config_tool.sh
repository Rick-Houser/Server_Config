#!/usr/bin/env bash

# This script will setup and configure LAMP stack to run a simple PHP web app

# Check for package manager updates
sudo apt-get update

# Install Apache
sudo apt-get install apache2

# Install MySQL and a helper package
sudo apt-get install mysql-server php5-mysql

# Create the MySQL database
sudo mysql_install_db

# Secure our installation by removing insecure defaults
sudo mysql_secure_installation

# Install PHP and helper packages
sudo apt-get install php5 libapache2-mod-php5 php5-mcrypt

# Remove default .html file and replace it with our .php file
sudo rm /var/www/html/index.html
sudo touch /var/www/html/index.php

# Add requested php content to file
echo '<?php header("Content-Type: text/plain"); echo "Hello, world!\n";' >> /va$

# Restart apache service
sudo service apache2 restart
