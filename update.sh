#!/bin/bash

# Prompt the user for their reward address
read -p "Enter your reward address (in the format 0x...): " REWARD_ADDRESS

# Check if the address is empty
if [[ -z "$REWARD_ADDRESS" ]]; then
    echo "Error: Address cannot be empty."
    exit 1
fi

# Validate the address format
if [[ ! "$REWARD_ADDRESS" =~ ^0x[0-9a-fA-F]{40}$ ]]; then
    echo "Error: Invalid address format. Make sure it starts with '0x' and contains 40 characters after."
    exit 1
fi

# Execute the command with the provided address
curl -L https://github.com/cysic-labs/phase2_libs/releases/download/v1.0.0/setup_linux.sh > ~/setup_linux.sh
bash ~/setup_linux.sh "$REWARD_ADDRESS"

echo "Script completed. Used address: $REWARD_ADDRESS"
