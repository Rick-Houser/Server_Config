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

Funny name but very fun project. The script parses the CLI. Given a string, a voice option, and an IP address, the script takes the string and uploads a spoken version of the string in a voice of your choice. Current voice options are male(m), female(f) and robot(r).

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
