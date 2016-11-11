First issue found:
  Getting "No space left on device" error when attempting to scp folder to remote server.

Steps Taken:
  Ran commands du and df to check file space usage and file system disk usage.
  After running these commands I noticed there was a huge difference. Doing a quick google search, I happened to find this can happen when a large file has been deleted by is still open by some process. To find the culprit, I ran list open files command (lsof) and grep for the term "deleted". Tried killing the process still using the deleted file to no avail. Escalated the signal by passing the "-KILL" option.

Solution:
  Restart/kill the service that is using the deleted file.
