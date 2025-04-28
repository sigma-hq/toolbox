#!/bin/bash
#
# This script changes the hostname in Ubuntu permanently.
# It handles updating /etc/hostname and /etc/hosts.
#
# Usage: sudo ./change_hostname.sh <new_hostname>
#
# Example: sudo ./change_hostname.sh my-new-host

# Check if the script is run as root
if [[ $EUID -ne 0 ]]; then
  echo "This script must be run as root."
  exit 1
fi

# Check if the new hostname is provided
if [ -z "$1" ]; then
  echo "Please provide the new hostname as an argument."
  echo "Usage: sudo ./change_hostname.sh <new_hostname>"
  exit 1
fi

new_hostname="$1"
old_hostname=$(hostname) #get the old hostname

echo "Changing hostname to: $new_hostname"

# 1. Update /etc/hostname
echo "$new_hostname" > /etc/hostname
echo "Updated /etc/hostname"

# 2. Update /etc/hosts
# Use sed to replace the line containing the old hostname with the new hostname.
# This assumes that the /etc/hosts file has a line like:
# 127.0.0.1  old-hostname
# If the file is formatted differently, this might need adjustment.
sed -i "s/127.0.0.1[[:space:]]*$old_hostname/127.0.0.1 $new_hostname/g" /etc/hosts
echo "Updated /etc/hosts"

# 3. Apply the change immediately (without rebooting)
hostname "$new_hostname"
echo "Hostname changed immediately (without rebooting)"

# 4. Print new hostname
echo "New hostname: $(hostname)"

echo "Hostname change complete.  You may need to reboot for all applications to recognize the change."
exit 0
