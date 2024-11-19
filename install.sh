#!/bin/bash

# Завантаження та виконання common.sh
source <(curl -s https://raw.githubusercontent.com/R1M-NODES/utils/master/common.sh)
printLogo

# Перевірка або запит EVM-адреси
if [ -z "$1" ]; then
  read -p "Введіть вашу EVM-адресу: " EVM_ADDR
else
  EVM_ADDR=$1
fi

set -e

sudo apt-get update
sudo apt-get install -y ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

cat > docker-compose.yml <<EOF
services:
  verifier:
    image: whoami39/cysic-verifier:latest
    container_name: verifier
    environment:
      - EVM_ADDR=${EVM_ADDR}
    volumes:
      - ./data/data:/app/data
      - ./data/cysic/:/root/.cysic/
      - ./data/scroll_prover:/root/.scroll_prover
    network_mode: "host"
    restart: unless-stopped
EOF

sudo docker-compose up -d
