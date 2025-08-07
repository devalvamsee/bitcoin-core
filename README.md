# 🪙 Bitcoin Regtest Docker Network

This project sets up a private Bitcoin network using Docker, running in `regtest` mode. It includes two nodes (`node1` and `node2`), simulating a Bitcoin network locally for testing, mining, and development.

---

## 📁 Directory Structure

bitcoin-regtest-docker/
├── Dockerfile
├── docker-compose.yaml
├── setup.sh
└── README.md

---

## 🛠️ Requirements

- [Docker](https://www.docker.com/)
- [Docker Compose](https://docs.docker.com/compose/)

---

## 📦 Setup Instructions

### 1. Clone the Repository

```
git clone https://github.com/yourusername/bitcoin-regtest-docker.git
cd bitcoin-regtest-docker
2. Build and Start the Bitcoin Nodes

docker-compose down -v    # Clean up any existing containers/volumes
docker-compose build      # Build Docker images
docker-compose up -d      # Start containers in detached mode
3. Run the Setup Script

./setup.sh
This script will:

Wait for both Bitcoin nodes to be ready

Create wallets on both nodes

Mine 101 blocks on node1 to unlock rewards

Send 10 BTC from node1 to node2

Mine 1 more block to confirm the transaction

🔧 Manual Commands
Check Balance
node1:

docker exec node1 bitcoin-cli -regtest -rpcuser=user -rpcpassword=pass getbalance
node2:

docker exec node2 bitcoin-cli -regtest -rpcuser=user -rpcpassword=pass -rpcport=18446 getbalance
Send BTC from node1 to node2
Get a new address on node2:

docker exec node2 bitcoin-cli -regtest -rpcuser=user -rpcpassword=pass -rpcport=18446 getnewaddress
Send BTC from node1 to the address:

docker exec node1 bitcoin-cli -regtest -rpcuser=user -rpcpassword=pass sendtoaddress <ADDRESS> 5
Mine a block on node1 to confirm:

docker exec node1 bitcoin-cli -regtest -rpcuser=user -rpcpassword=pass generatetoaddress 1 "$(docker exec node1 bitcoin-cli -regtest -rpcuser=user -rpcpassword=pass getnewaddress)"
🧹 Cleanup
To stop and remove all containers and volumes:

docker-compose down -v
