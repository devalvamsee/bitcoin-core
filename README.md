# 📄 Bitcoin Regtest Docker Setup

## 🚀 Project Overview

This project sets up a **2-node Bitcoin Core network** in **regtest mode** using Docker. It is ideal for testing and learning purposes in a private blockchain environment.

## 🛠️ Prerequisites

- [Docker](https://www.docker.com/)
- [Docker Compose](https://docs.docker.com/compose/)
- Unix-based shell (`bash`)
- Internet connection (for initial Docker image pull)

## 📁 Directory Structure

```
bitcoin-core/
├── Dockerfile
├── docker-compose.yaml
├── Documentation.md 
├── setup.sh
└── README.md
```

## ⚙️ Setup Instructions

### 1. Clone the Repository

```
git clone git@github.com:devalvamsee/bitcoin-core.git
cd bitcoin-core
```

### 2. Build and Start the Docker Containers

```
docker-compose down -v       # Clean previous volumes
docker-compose build         # Build the Docker images
docker-compose up -d         # Start containers in detached mode
```

### 3. Initialize the Network

Run the setup script to:

- Wait for both nodes to be ready
- Create wallets on both nodes
- Mine 101 blocks on node1
- Send 10 BTC to node2
- Mine another block to confirm the transaction
- Display the balance of node2

```
./setup.sh
```

## 🧪 Useful Docker Commands

### Get blockchain info

```
docker exec node1 bitcoin-cli -regtest -rpcuser=user -rpcpassword=pass getblockchaininfo
```

### Get new address

```
docker exec node1 bitcoin-cli -regtest -rpcuser=user -rpcpassword=pass getnewaddress
```

### Check wallet balance

```
docker exec node2 bitcoin-cli -regtest -rpcuser=user -rpcpassword=pass getbalance
```

### View peer connections

```
docker exec node1 bitcoin-cli -regtest -rpcuser=user -rpcpassword=pass getpeerinfo
```

## 🧹 Cleaning Up

To stop and remove all running containers, networks, and volumes:

```
docker-compose down -v
```

## ⚙️ Configuration Details

- **Regtest Mode**: Allows instant block generation and testing.
- **Node RPC Ports**:
  - node1: 18443 (RPC), 18444 (P2P)
  - node2: 18446 (RPC), 18445 (P2P)
- **Wallets**:
  - `wallet1` (node1)
  - `wallet2` (node2)

## 📌 Notes

- Ensure the fallback transaction fee is enabled in your Bitcoin config if needed for transactions.
- Regtest is offline; nothing is connected to Bitcoin mainnet or testnet.

## 📧 Contact

Raise an issue in the repository for any questions or assistance.

---

