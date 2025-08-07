# 🪙 Bitcoin Regtest Docker Network

This project sets up a **private Bitcoin regtest network** using **Docker** and **bitcoin-core**. It includes two nodes (`node1` and `node2`) configured to connect with each other and interact via RPC.

---

## 🚀 Features

- Two Bitcoin nodes running in `regtest` mode
- Wallet creation for both nodes
- Mining and sending BTC transactions
- Automatic setup using `setup.sh`
- Based on the official `bitcoin-core` Docker image

---

## 📁 Directory Structure

bitcoin-regtest-docker/
├── Dockerfile
├── docker-compose.yaml
├── setup.sh
└── README.md
---

## 🛠️ Requirements

- Docker
- Docker Compose

---

## 📦 Setup Instructions

### 1. Clone the Repository

git clone https://github.com/yourusername/bitcoin-regtest-docker.git
cd bitcoin-regtest-docker
2. Build and Start the Nodes
docker-compose down -v        # Clean up any previous runs
docker-compose build          # Build the Docker image
docker-compose up -d          # Start the Bitcoin nodes
3. Run the Setup Script
./setup.sh
This script will:

Wait for both nodes to be ready

Create wallets on both nodes

Mine 101 blocks on node1 (to activate coinbase rewards)

Send 10 BTC to an address on node2

Mine 1 more block to confirm the transaction

🔧 Interacting with Nodes Manually
Get Balance of node1
docker exec node1 bitcoin-cli -regtest -rpcuser=user -rpcpassword=pass getbalance
Get Balance of node2
docker exec node2 bitcoin-cli -regtest -rpcuser=user -rpcpassword=pass -rpcport=18446 getbalance
Send BTC from node1 to node2
docker exec node2 bitcoin-cli -regtest -rpcuser=user -rpcpassword=pass -rpcport=18446 getnewaddress

# Use the address above in this command:
docker exec node1 bitcoin-cli -regtest -rpcuser=user -rpcpassword=pass sendtoaddress <ADDRESS> 5
Then mine a block to confirm:
docker exec node1 bitcoin-cli -regtest -rpcuser=user -rpcpassword=pass generatetoaddress 1 "$(docker exec node1 bitcoin-cli -regtest -rpcuser=user -rpcpassword=pass getnewaddress)"
🧹 Cleanup
To stop and remove everything:
docker-compose down -v
