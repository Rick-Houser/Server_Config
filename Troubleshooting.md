Issue #1:
  Getting "No space left on device" error when attempting to scp folder to remote server.

Steps Taken:
  Ran commands du and df to check file space usage and file system disk usage.
  After running these commands I noticed there was a huge difference. Doing a quick google search, I happened to find this can happen when a large file has been deleted by is still open by some process. To find the culprit, I ran list open files command (lsof) and grep for the term "deleted". Tried killing the process still using the deleted file to no avail. Escalated the signal by passing the "-KILL" option.

Solution:
  Restart/kill the service that is using the deleted file.


Issue #2:
  "sudo: unable to resolve host" error when running sudo
  "Err http://us-east-1.ec2.archive.ubuntu.com/ubuntu/ trusty/universe libmodule-find-perl all 0.11-1
  Could not resolve 'us-east-1.ec2.archive.ubuntu.com'
  Err http://us-east-1.ec2.archive.ubuntu.com/ubuntu/ trusty/universe needrestart all 0.5-1
    Could not resolve 'us-east-1.ec2.archive.ubuntu.com'
  E: Failed to fetch http://us-east-1.ec2.archive.ubuntu.com/ubuntu/pool/universe/libm/libmodule-find-perl/libmodule-find-perl_0.11-1_all.deb  Could not resolve 'us-east-1.ec2.archive.ubuntu.com'
  "

Steps Taken:
  Checked /etc/hostname for correct hostname.
  Checked /etc/hosts and found hostname missing.

Soluton:
  Added hostname to /etc/hosts

--->>>Issue #3:<<<---
  Getting errors when trying to run apt-get.

Steps Taken:
  After checking /etc/resolv.conf I noticed a general 127.0.0.1 IP.
  As a temporary solution, I replaced it with google's DNS 8.8.8.8.

Solution:

Issue #4:
  * Restarting web server apache2                                                                                                                                                   AH00558: apache2: Could not reliably determine the server's fully qualified domain name, using 127.0.0.1. Set the 'ServerName' directive globally to suppress this message
  (98)Address already in use: AH00072: make_sock: could not bind to address [::]:80
  (98)Address already in use: AH00072: make_sock: could not bind to address 0.0.0.0:80
  no listening sockets available, shutting down
  AH00015: Unable to open logs
  Action 'start' failed.
  The Apache error log may have more information.

  Steps Taken:
    Using netstat command, I found that another process is listening on port 80
    Looked up info about the process and killed it. This got rid of all but error AH00558. Searched online and found others with similar issues.
    Tried curl and realized packets weren't getting through. Ran nmap and saw that port 80 had the "filtered" status. Checked iptables and saw connections to port 80 were being dropped. Flushed that rule.

  Solution(part1):
    Kill the process listening on port 80.
    Add "ServerName ip-172-31-255-189" to apache2.conf file.
    Remove iptables rule that's dropping internet traffic.
