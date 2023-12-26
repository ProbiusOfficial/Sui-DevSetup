#!/bin/bash

RELEASE="mainnet-v1.15.1"

sudo apt-get update
sudo apt-get install -y curl tar

curl -L https://github.com/MystenLabs/sui/releases/download/${RELEASE}/sui-${RELEASE}-ubuntu-x86_64.tgz | tar xz

sudo mkdir /sui
sudo mv ./target/release/sui-faucet-ubuntu-x86_64 /sui/sui-faucet
sudo mv ./target/release/sui-node-ubuntu-x86_64 /sui/sui-node
sudo mv ./target/release/sui-test-validator-ubuntu-x86_64 /sui/sui-test-validator
sudo mv ./target/release/sui-tool-ubuntu-x86_64 /sui/sui-tool
sudo mv ./target/release/sui-ubuntu-x86_64 /sui/sui

# 配置环境变量
echo 'export PATH="/sui:$PATH"' >> $HOME/.bashrc

echo "Sui installation completed. Please run 'source $HOME/.bashrc' to update the PATH."
