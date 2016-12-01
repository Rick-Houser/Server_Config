#!/usr/bin/env bash

# This tool will check for updates and existing files before proceeding to setup
# and configure LAMP stack to run a simple PHP web app.
# See included README for instructions on usage and configuration.

# Check for package manager updates
sudo apt-get update

# --------------------------
# Remove Debian Packages
# --------------------------

# Runs only if uninstall list is not empty
if [ -s debian_packages/uninstall.txt ]; then
  # Populate our removal_list array
  declare -a removal_list
  while IFS='\n' read -r value; do
    removal_list+=( "${value}" )
  done < "debian_packages/uninstall.txt"

  # Iterate removal_list. Remove if not already removed.
  for rm_pkg in "${removal_list[@]}"
  do
    if dpkg -l | grep -i "${rm_pkg}"; then
      sudo apt-get remove "${rm_pkg}" # Remove package
      sudo apt-get autoremove # Remove packages installed by other packages that aren't needed
      sudo apt-get purge -y $(dpkg --list |grep '^rc' |awk '{print $2}') # Remove package config files
      sudo apt-get clean # Removes .deb files no longer installed.
    fi
  done
fi

# --------------------------
# Install Debian Packages
# --------------------------

# Runs only if install list is not empty
if [ -s debian_packages/install.txt ]; then
  # Populate our install_list array
  declare -a install_list
  while IFS='\n' read -r value; do
    install_list+=( "${value}" )
  done < "debian_packages/install.txt"

  # Iterate install_list array. Install if not already installed.
  for in_pkg in "${install_list[@]}"
  do
    if ! dpkg -l | grep "${in_pkg}"; then
      sudo apt-get install -y "${in_pkg}"
      if [ "${in_pkg}" == "mysql-server" ]; then
        # Create the MySQL database
        sudo mysql_install_db

        # Secure our installation by removing insecure defaults
        sudo mysql_secure_installation
      fi
    fi
  done
fi

# --------------------------
# Setting Metadata and Content
# --------------------------

# Replace default index.html with index.php if the file exists
if [ -f "/var/www/html/index.html" ]; then
  sudo rm /var/www/html/index.html
  touch /var/www/html/index.php
fi

# Build our associative array from key val pairs in metadata.txt
# Note: Separator and order are important in this text file

# Runs only if uninstall list is not empty
if [ -s metadata.txt ]; then
  declare -A metadata
  while IFS== read -r key value; do
    metadata[$key]=$value
  done < "metadata.txt"
  sudo chmod "${metadata[permissions]}" "${metadata[file]}"
  sudo chown "${metadata[owner]}" "${metadata[file]}"
  sudo chgrp "${metadata[group]}" "${metadata[file]}"
  sudo echo "${metadata[content]}" > "${metadata[file]}"
fi

# --------------------------
# Check for Required Restart
# --------------------------
needrestart
