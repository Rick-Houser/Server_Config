#!/usr/bin/env bash

# Install package to help automate the ssh process.
# This helps to avoid requiring the user type their ssh password.
# Usage:
#   export SSHPASS=password
#   sshpass -e ssh user@remotehost
sudo apt-get install sshpass
