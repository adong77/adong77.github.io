#!/bin/bash

HOST=81.68.230.48
USERNAME=ubuntu
PASSWORD=A11b22c33
PUBLIC=/mnt/d/github/adong77.github.io/public/*
BLOG=/var/www/html/blog/

scp -r $PUBLIC $USERNAME@$HOST:$BLOG
  
# lftp -u $USERNAME,$PASSWORD sftp://$HOST << EOF
#   cd /var/www/html/blog/
#   lcd /mnt/d/github/adong77.github.io/public/
#   mput *
#   bye 
# EOF

