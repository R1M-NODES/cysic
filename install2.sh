#!/bin/bash

source <(curl -s https://raw.githubusercontent.com/R1M-NODES/utils/master/common.sh)
printLogo

# Prompt the user to input their reward address
echo "Please enter your EVM reward address:"
read REWARD_ADDRESS

# Check if the address is provided
if [ -z "$REWARD_ADDRESS" ]; then
    echo "Error: Reward address cannot be empty!"
    exit 1
fi

# Step 1: Download and run the setup script
echo "Downloading and executing setup script..."
curl -L https://github.com/cysic-labs/phase2_libs/releases/download/v1.0.0/setup_linux.sh -o ~/setup_linux.sh

if [ $? -ne 0 ]; then
    echo "Error downloading setup_linux.sh."
    exit 1
fi

chmod +x ~/setup_linux.sh
bash ~/setup_linux.sh $REWARD_ADDRESS

if [ $? -ne 0 ]; then
    echo "Error executing setup_linux.sh."
    exit 1
fi

# Step 2: Navigate to the directory and start the verifier
echo "Starting the verifier program..."
cd ~/cysic-verifier/ && bash start.sh

if [ $? -ne 0 ]; then
    echo "Error starting the verifier."
    exit 1
fi

# Final message
echo "Verifier is running. Please wait a few minutes for the connection to establish."
echo "If you need to reconnect, run: cd ~/cysic-verifier/ && bash start.sh"
