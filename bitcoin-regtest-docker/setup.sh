#!/bin/bash

set -e

# Node1 config
RPCUSER=user
RPCPASS=pass
RPCPORT_NODE1=18443
RPCPORT_NODE2=18446

# Wait for node1 to become responsive
echo "⏳ Waiting for node1 RPC to be available..."
until docker exec node1 bitcoin-cli -regtest -rpcuser=$RPCUSER -rpcpassword=$RPCPASS -rpcport=$RPCPORT_NODE1 getblockchaininfo &>/dev/null; do
  echo "🔄 Still waiting for node1..."
  sleep 2
done

# Wait for node2 to become responsive
echo "⏳ Waiting for node2 RPC to be available..."
until docker exec node2 bitcoin-cli -regtest -rpcuser=$RPCUSER -rpcpassword=$RPCPASS -rpcport=$RPCPORT_NODE2 getblockchaininfo &>/dev/null; do
  echo "🔄 Still waiting for node2..."
  sleep 2
done

echo "🔐 Creating wallets..."
docker exec node1 bitcoin-cli -regtest -rpcuser=$RPCUSER -rpcpassword=$RPCPASS -rpcport=$RPCPORT_NODE1 createwallet "wallet1" || true
docker exec node2 bitcoin-cli -regtest -rpcuser=$RPCUSER -rpcpassword=$RPCPASS -rpcport=$RPCPORT_NODE2 createwallet "wallet2" || true

echo "⛏️  Mining 101 blocks on node1..."
MINER_ADDR=$(docker exec node1 bitcoin-cli -regtest -rpcuser=$RPCUSER -rpcpassword=$RPCPASS -rpcport=$RPCPORT_NODE1 getnewaddress)
docker exec node1 bitcoin-cli -regtest -rpcuser=$RPCUSER -rpcpassword=$RPCPASS -rpcport=$RPCPORT_NODE1 generatetoaddress 101 "$MINER_ADDR"

echo "💸 Sending 10 BTC to node2..."
RECEIVER_ADDR=$(docker exec node2 bitcoin-cli -regtest -rpcuser=$RPCUSER -rpcpassword=$RPCPASS -rpcport=$RPCPORT_NODE2 getnewaddress)
TXID=$(docker exec node1 bitcoin-cli -regtest -rpcuser=$RPCUSER -rpcpassword=$RPCPASS -rpcport=$RPCPORT_NODE1 sendtoaddress "$RECEIVER_ADDR" 10)

echo "⛏️  Mining 1 more block to confirm..."
CONFIRM_ADDR=$(docker exec node1 bitcoin-cli -regtest -rpcuser=$RPCUSER -rpcpassword=$RPCPASS -rpcport=$RPCPORT_NODE1 getnewaddress)
docker exec node1 bitcoin-cli -regtest -rpcuser=$RPCUSER -rpcpassword=$RPCPASS -rpcport=$RPCPORT_NODE1 generatetoaddress 1 "$CONFIRM_ADDR"

echo "✅ Transaction sent! TXID: $TXID"
BALANCE=$(docker exec node2 bitcoin-cli -regtest -rpcuser=$RPCUSER -rpcpassword=$RPCPASS -rpcport=$RPCPORT_NODE2 getbalance)
echo "💰 node2 balance: $BALANCE BTC"

