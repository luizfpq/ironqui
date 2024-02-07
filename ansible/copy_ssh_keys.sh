#!/bin/bash

# Read the inventory file
inventory_file="inventory.ini"

while IFS= read -r line; do
    # Extract values from the line
    host=$(echo "$line" | awk '{print $1}')
    ip=$(echo "$line" | awk -F "=" '{print $2}' | awk '{print $2}')
    ssh_user=$(echo "$line" | awk -F "=" '{print $3}' | awk '{print $2}')
    ssh_pass=$(echo "$line" | awk -F "=" '{print $4}' | awk '{print $2}')

    # Execute ssh-copy-id command
    echo "Copying SSH key to $host..."
    sshpass -p "$ssh_pass" ssh-copy-id "$ssh_user@$ip"

    # Check for errors and print in red if any
    if [ $? -eq 0 ]; then
        echo -e "\e[32mSSH key copied successfully to $host\e[0m"
    else
        echo -e "\e[91mError copying SSH key to $host\e[0m"
    fi

done < "$inventory_file"
