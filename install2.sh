#!/bin/bash

source <(curl -s https://raw.githubusercontent.com/R1M-NODES/utils/master/common.sh)
printLogo

# Step 1: Setup
echo "Step 1: Setup"

if [ -z "$1" ]; then
  read -p "Enter your reward address (EVM address): " REWARD_ADDRESS
else
  REWARD_ADDRESS=$1
fi

if [[ ! $REWARD_ADDRESS =~ ^0x[a-fA-F0-9]{40}$ ]]; then
  echo "Invalid EVM address. Please provide a valid one starting with 0x."
  exit 1
fi

echo "Downloading and running the setup script..."
curl -L https://github.com/cysic-labs/phase2_libs/releases/download/v1.0.0/setup_linux.sh > ~/setup_linux.sh
bash ~/setup_linux.sh $REWARD_ADDRESS

# Step 2: Start the Verifier Program
echo "Step 2: Start the Verifier Program"

cd ~/cysic-verifier/ || { echo "Verifier directory not found. Ensure setup completed successfully."; exit 1; }

bash start.sh

echo "🎉 Success! The verifier is now running."
echo "If you encounter an 'err: rpc error' message, wait a few minutes for the verifier to connect."
echo "Once connected, you'll see a message like 'start sync data from server,' indicating it is running successfully."
echo "Your mnemonic files are located in: ~/.cysic/keys/. Keep them safe, or you won't be able to rerun the verifier program."
