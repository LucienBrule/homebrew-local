#!/bin/bash

# Mount NFS share
mount -t nfs -o resvport,vers=3 192.168.1.10:/nfs/share /Users/lucienbrule/Developer/nfs

# Check if mount was successful
if [ $? -eq 0 ]; then
    echo "NFS share mounted successfully"
else
    echo "Failed to mount NFS share"
fi