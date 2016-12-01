## Issue #1:
  Error "No space left on device" occurred when attempting to transfer the config tool to the remote server.

### Steps Taken:
  Ran commands `du -sh` and `df -h` to check file space usage and file system disk usage.
  After running these commands I noticed there was a huge difference. Doing a quick google search, I happened to find this can happen when a large file has been deleted but is still open by some process. To find the culprit, I checked for open files and searched for the term "deleted", with `lsof | grep "deleted"` commands.
  I tried killing the process that is still using the deleted file with the `kill` command. This didn't work so I escalated the signal by passing the `-KILL` option to the `kill` command on the ID of the process (PID).

### Solution:
  Killed the service that is using the deleted file.

-------------------------------------------------------------------------------

## Issue #2:
  Error `sudo: unable to resolve host` occurred when running "sudo" command.

### Steps Taken:
  Considering the error gave hints at where to look, I decided to check the directories containing host information.
  Checked `/etc/hostname` for correct hostname.
  Checked `/etc/hosts` and found hostname missing.

### Solution:
  Added hostname (ip-172-31-255-189) to `/etc/hosts`

-------------------------------------------------------------------------------

## Issue #3:
  Received multiple errors when trying to run apt-get.

### Steps Taken:
  A quick search for the errors received when trying to run apt-get pointed me to `/etc/resolv.conf`.
  After checking `/etc/resolv.conf`, I noticed a general "127.0.0.1" IP address.
  I replaced it with "8.8.8.8" (Google DNS).

### Solution:
  Replaced 127.0.0.1 with Google DNS.

-------------------------------------------------------------------------------

## Issue #4:
  Encountered multiple errors when running lumos_config tool. The solution involved has two parts.

  Error 1: "AH00558: apache2: Could not reliably determine the server's fully qualified domain name, using 127.0.0.1. Set the 'ServerName' directive globally to suppress this message"

  Error 2: "(98)Address already in use: AH00072: make_sock: could not bind to address [::]:80"

### Steps Taken(Error 1):
  I Searched online for the AH00558 error and found others with similar issues. Adding servername to apache2.conf file resolved the issue.

### Solution(Error 1):
  I added "ServerName ip-172-31-255-189" to the apache2.conf file.

### Steps Taken(Error 2)
  The second error hints at issues with port 80. Using the `netstat -plnt` command, I found that another process is listening on port 80.
  I looked up the process ID and and killed the process that was listening on port 80.

### Solution(Error 2):
  I killed the process listening on port 80.

-------------------------------------------------------------------------------

## Issue #5:
  I ran the curl command as requested but never succeeded.

### Steps Taken:
  I tried curl and realized packets weren't getting through.
  I ran the `nmap -sV IP_ADDRESS` command from my computer and saw that port 80 had the "filtered" status. I checked iptables and saw connections to port 80 were being dropped. I used the `sudo iptables -F` command and flushed that rule. Had there been more than the one rule in place, I would have flushed just the one rule and left the others in place.

### Solution:
  I flushed the iptables rule that was dropping connections.
