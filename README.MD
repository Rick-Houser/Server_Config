# Lumos

This is a very rudimentary configuration management tool. This tool can be used
to configure servers for the production service of a simple PHP application. This tool is modeled after industry tools such as Puppet, Chef, Fabric and Ansible.

I really enjoyed this challenge as it led to me gaining a deeper understanding of automating server configuration. I considered many options on how to structure this tool and my first iteration consisted simply of a list of install commands. Upon further reading, I decided to implement arrays in Bash 4. I chose this approach as it more closely resembles the hash structure Puppet uses when handling resources.

For the second part of the challenge I am tasked with troubleshooting a severely misconfigured server. In the process I document the server issue, the steps taken, and the solution. See my notes in [Troubleshooting.md](https://github.com/Rick-Houser/Server_Config/blob/master/Troubleshooting.md).

## Abstractions:

1. Automates setup of LAMP stack
1. Install specific Debian packages
1. Remove specific Debian packages
1. Specify content and metadata for files and directories
1. Will check for services that need to be restarted

## Structure:
``` bash
  Server_Config/
  +-- bootstrap.sh
  +-- lumos_config.sh
  +-- metadata.txt
  +-- debian_packages
      +-- install.txt
      +-- uninstall.txt
```

## How to Configure:

* To install a package, add the package name to the text file labeled "install.txt" inside the "debian_packages" directory. Each package name should be on it's own line without any trailing whitespace.
* For removing an installed package, follow you will do the same as you did to install a package. This time you will add the package names to the "uninstall.txt" file inside the "debian_packages" directory.
* To set metadata and file content, you will need to add key value pairs into the "metadata.txt" file. Key value pairs must be separated by "=" and each on it's own line. Again, trailing whitespace should be avoided. Inside the metadata file, you will find examples from which you can edit.

## **_Usage_**

* Transfer directory to the destination server using the following syntax:

  ```bash
  scp -r Server_Config/ your_username@remotehost
  ```

* CD into the directory

  ```bash
  cd Server_Config/
  ```

* Make the scripts executable

  ```bash
  chmod +x lumos_config.sh bootstrap.sh
  ```

* Install dependency

  ```bash
  ./bootstrap.sh
  ```

* Run the script

  ```bash
  ./lumos_config.sh
  ```
