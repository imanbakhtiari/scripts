#!/bin/bash

remoteip="ip add"
username="username"
# Backup creation
gitlab-rake gitlab:backup:create >> /var/log/logfile_12pm 2>&1

# Sync backups to remote server
rsync -avz /var/opt/gitlab/backups/ $username@$remoteip:/var/backups/GIT >> /var/log/logfile_12pm 2>&1

# Cleanup old backups (keep only the last two weeks)
find /var/opt/gitlab/backups/ -type f -mtime +14 -delete
