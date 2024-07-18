#!/bin/bash

LOG_FILE="/tmp/nfsmount.log"

log_message() {
    echo "$(date): $1" >> "$LOG_FILE"
}

mount_nfs() {
    log_message "Attempting to mount NFS share"
    if sudo mount -t nfs -o noacl,rw,resvport,vers=3 192.168.1.10:/nfs/share /Users/lucienbrule/Developer/nfs; then
        log_message "NFS share mounted successfully"
    else
        log_message "Failed to mount NFS share"
        exit 1
    fi
}

mount_nfs

while true; do
    sleep 60
done
