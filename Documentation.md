
# Bitcoin Regtest Transaction System

## 📄 Overview
This project sets up a Bitcoin regtest network using Docker and performs a transaction between two nodes (`node1` → `node2`) automatically using a shell script.

## 🧱 Architecture

- **node1**: First Bitcoin regtest node, used to mine and send transactions.
- **node2**: Second node that connects to node1 and receives transactions.
- **Docker Compose**: Used to manage containerized nodes.
- **setup.sh**: Automates wallet creation, block mining, and transactions.

## 🧪 How It Works

1. Launch two regtest nodes using `docker-compose up -d`.
2. `setup.sh` waits for both nodes' RPCs to become available.
3. Wallets are created for each node (if not already created).
4. node1 mines 101 blocks to unlock coinbase rewards.
5. node1 sends 10 BTC to node2's address.
6. node1 mines one more block to confirm the transaction.
7. Final balance of node2 is printed.

## 🚀 Quick Start

```bash
git clone git@github.com:devalvamsee/bitcoin-core.git
cd bitcoin-core

# Start the network
docker-compose up -d

# Run transaction script
./setup.sh
```

## ♻️ Repeat Transactions

You can re-run `setup.sh` any number of times to create and confirm a new transaction on the network.

## 🧼 Cleanup

```bash
docker-compose down -v
```

This will stop and remove containers, network, and volumes.

## 📁 Files

| File                     | Purpose                                 |
|--------------------------|------------------------------------------|
| `docker-compose.yaml`    | Defines the two Bitcoin nodes            |
| `Dockerfile`             | Builds a Bitcoin Core image              |
| `setup.sh`               | Automates the wallet + transaction flow  |
| `.github/workflows/ci.yml` | CI pipeline to lint scripts           |
| `README.md`              | Basic setup guide                        |
| `Documentation.md`       | Detailed overview (this file)            |

## ✅ CI/CD

- **CI**: Shell and Dockerfile linting with GitHub Actions.
- **CD**: GitHub workflow that builds and runs the network (via `workflow_dispatch`).
