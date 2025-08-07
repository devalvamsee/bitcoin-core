FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive
ENV BITCOIN_VERSION=25.1

# Install dependencies
RUN apt-get update && apt-get install -y \
    curl gnupg tar ca-certificates && \
    mkdir /bitcoin && \
    curl -O https://bitcoincore.org/bin/bitcoin-core-${BITCOIN_VERSION}/bitcoin-${BITCOIN_VERSION}-x86_64-linux-gnu.tar.gz && \
    tar -xzf bitcoin-${BITCOIN_VERSION}-x86_64-linux-gnu.tar.gz && \
    mv bitcoin-${BITCOIN_VERSION}/bin/* /usr/local/bin/ && \
    rm -rf bitcoin-${BITCOIN_VERSION}*

# Create data dir
VOLUME /bitcoin
WORKDIR /bitcoin

EXPOSE 18443 18444
CMD ["bitcoind"]

