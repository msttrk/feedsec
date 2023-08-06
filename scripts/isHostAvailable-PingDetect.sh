#!/bin/bash

# Give file with IP addresses to control
INPUT_FILE="$1"

# unreachable IP addresses list file
UNREACHABLE_IPS="unreachable_ips.txt"

# Does the input file is given?
if [ -z "$INPUT_FILE" ]; then
    echo "Please give the file contain IP Addresses."
    exit 1
fi

# Does the file exists?
if [ ! -f "$INPUT_FILE" ]; then
    echo "$INPUT_FILE file is not found!"
    exit 1
fi

# Does temporary file is exist?
if [ -f "$UNREACHABLE_IPS" ]; then
    rm -f "$UNREACHABLE_IPS"
fi

# Check the IP addresses
while IFS= read -r ip
do
    # Send 1 ping.
    ping -c 1 "$ip" > /dev/null 2>&1
    # If ping is not successful write the IP address to the file
    if [ $? -ne 0 ]; then
        echo "$ip" >> "$UNREACHABLE_IPS"
    fi
done < "$INPUT_FILE"

# Print the unreachable IP addresses to screen
if [ -f "$UNREACHABLE_IPS" ]; then
    echo "Unreachable IP Addresses:"
    cat "$UNREACHABLE_IPS"
    rm -f "$UNREACHABLE_IPS"
else
    echo "All IP addresses are reachable!"
fi
