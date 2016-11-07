# Rick Houser's Configuration Tool

This is a very rudimentary configuration management tool. This tool can be used
to configure servers for the production service of a simple PHP application. This tool is modeled after professional tools such as Puppet, Chef, Fabric and Ansible.

I really enjoyed this challenge as it led to me gaining a deeper understanding of automating server configuration, which is cool. I considered many options on how to structure this tool. It's first iteration was simply a list of install commands. Upon further reading, I learned to implement arrays in Bash 4. I chose this approach as it more closely resembles the hash structure Puppet uses when handling resources.

## Operations:

1. Automates setup of LAMP stack
1. Can install specific debian packages
1. Can remove specific debian packages
1. Can configure metadata for files and directories
1. Ability to configure metadata recursively
1. Option for specifying a file's content
1. Will restart a specified service on each run

## How to configure:

Reading from top to bottom, I'll describe each section of the tool.
* First the package manager will check for updates.
* Removing Debian Packages. The section that's labeled "Remove Debian Packages" does just that. This block of code is commented out by default. Should you wish to uninstall a specific debian package, you will need to uncomment this block and add the package name to the array "remove_packages". It is important that each package is only separated by one space as illustrated by the current example. The code will only run if the package is currently installed.
* Installing Debian Packages. In the appropriately labeled block of code, you will find an array of debian packages to install. This code block iterates through the list of packages and calls apt-get to install each one. There is an additional step here specifically for mysql-server. This is needed to ensure a secure mysql installation. You will be prompted to set a password during installation. These packages will only be installed if they aren't currently installed.
* Preparing the index. On default install, we have an existing index.html page. Since ours is a PHP application, I chose to simply remove the default index.html page and replace it with an index.php page. We will set content and metadata next.
* Setting metadata and content. The associative array called "metadata" is used to set various directory and file metadata as well as content.
* Recursively setting metadata. The following block that is commented out allows one to set metadata for all files and directories within a given directory.
* Finally, our tool will restart a given service on each run.

## **_Usage_**

* Transfer script to the destination server using the following syntax:

  ```bash
  scp ricks_config_tool.sh your_username@remotehost:/some/remote/directory
  ```

* Make the script executable

  ```bash
  chmod +x ricks_config_tool.sh
  ```

* Run the script from the CLI

  ```bash
  ./ricks_config_tool
  ```
