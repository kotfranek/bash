#!/bin/sh
# Linux Disk Mount and Autorun

# Desired disk UUID, which will be mounted right after insertion
DISK_UUID="60527529527504D6"

# Mount point. Will be created if needed
MNT_PATH="/mnt/backup"

# Executed after disk was mounted.
# Paste your calls here. 
# Remark: this is being run with the root privileges, so be careful!
postMount()
{
    logger "Autorun: Disk mounted!"
}

# The first argument is the inserted device's UUID
ARG_DISK_UUID="$1"
DEV_PATH="/dev/disk/by-uuid/$ARG_DISK_UUID"

# Mount delay in seconds
DELAY_MOUNT=5

# Executed after the disk was connected.
# It will give 5 seconds before the mount is executed
waitAndMount()
{
    sleep $DELAY_MOUNT

    if [ ! -d "$MNT_PATH" ]
    then
        mkdir -p "$MNT_PATH"
    else
        # TODO: check, if path is not a mount-point already!
        echo
    fi
    mount "$DEV_PATH" "$MNT_PATH"

    # For safety, 500 msec
    sleep 0.5
    postMount
}

if [ "$DISK_UUID" == "$ARG_DISK_UUID"  ]
then
    waitAndMount &
fi
