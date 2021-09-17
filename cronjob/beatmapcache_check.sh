#!/bin/bash
# This script will check $beatmapCache_folder folder (aka. beatmap cache folder)'s total disk usage.
# If the folder/mount is greater than or equal to 90% disk usage, the script will remove files older than $delete_last_access (ie. 90) days.

# Variables
beatmapCache_folder="${BEATMAPCACHE_FOLDER:=/var/www/html/beatmapCache}" # beatmapCache folder path. eg. "/var/www/html/beatmapCache".
max_disk_usage_percentage="${MAX_DISK_USAGE_PERCENTAGE:=94}" # Max disk usage percentage (without the '%'). eg. "90" for 90%.
delete_last_access="${DELETE_LAST_ACCESS:=90}" # Time in days. eg. value of "90" means files last access within the last 91 days ("n*24 hours ago") will be removed in order to keep the disk usage below 90%.
delete_percentage_increment="${DELETE_PERCENTAGE_INCREMENT:=10}" # A percentage to reduce the $delete_last_access value by in the scenario that the storage is not being cleared fast enough (ie. someone is mirroring all the things).
discord_webhook_url="${DISCORD_WEBHOOK_URL:=}" # Discord webhook url. Leave blank if you don't wish to use.

# Message logging (to syslog and Discord).
function log_message () {
    log_msg="$1"
    logger -t bmcache "$log_msg"
    echo "$log_msg"

    # Send to discord if it's in use.
    if [ ! -z "$discord_webhook_url" ]; then
        discord_message="{\"username\": \"$(hostname)\", \"content\": \"${log_msg}\"}"
        curl -H "Content-Type: application/json" -X POST -d "$discord_message" "$discord_webhook_url"
    fi
}

function updateUsedPercentage() {
    # Check total storage used, and remove if greater than or equal to $max_disk_usage_percentage percent.
    used_storage_percentage=$(df -h $beatmapCache_folder | tail -n1 | awk '{print$5}' | sed -e 's/\%//g')
}

# Check if the beatmapCache folder exists!
if [ ! -d "${beatmapCache_folder}" ]; then
    log_message "Error: $beatmapCache_folder does not exist! $0 will not function until this has been resolved!"
    exit 1
fi

updateUsedPercentage

while [ "${used_storage_percentage}" -ge "${max_disk_usage_percentage}" ]; do
    log_message "Beatmap Cache path (${beatmapCache_folder}) is at or above ${max_disk_usage_percentage}% disk usage (${used_storage_percentage}% used), removing files that have not been accessed within $delete_last_access days."

    find "${beatmapCache_folder}" -depth -type f -atime "+${delete_last_access}" -delete &> /dev/null

    # Reduce last access used in next loop
    delete_last_access=$(printf %.0f $(echo "$delete_last_access * (1 - $delete_percentage_increment/100)" | bc -l))
    updateUsedPercentage    
done

log_message "Complete. There's currently $(df -h $beatmapCache_folder | tail -n1 | awk '{print$5}') free on $beatmapCache_folder"
