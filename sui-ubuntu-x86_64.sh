#!/bin/bash

# 使用参数指定的版本，如果未提供，则默认为 "mainnet-v1.15.1"
RELEASE=${1:-"mainnet-v1.15.1"}
FILENAME="sui-${RELEASE}-ubuntu-x86_64.tgz"

sudo apt-get update
sudo apt-get install -y curl tar

if [ -f "$FILENAME" ]; then
    echo "使用已下载的文件 $FILENAME"
    tar xz -f $FILENAME
else
    echo "Download $FILENAME"
    if ! curl -L "https://github.com/MystenLabs/sui/releases/download/${RELEASE}/${FILENAME}" | tar xz; then
        echo "下载失败，请检查网络连接后重试或手动下载：https://github.com/MystenLabs/sui/releases/"
        echo "下载完成后，请将压缩包放置在脚本同级目录带上版本号重新运行脚本 .eg: ./sui-ubuntu-x86_64.sh mainnet-v1.15.1"
        exit 1
    fi
fi

sudo mkdir -p /sui
sudo mv ./target/release/sui-faucet-ubuntu-x86_64 /sui/sui-faucet
sudo mv ./target/release/sui-node-ubuntu-x86_64 /sui/sui-node
sudo mv ./target/release/sui-test-validator-ubuntu-x86_64 /sui/sui-test-validator
sudo mv ./target/release/sui-tool-ubuntu-x86_64 /sui/sui-tool
sudo mv ./target/release/sui-ubuntu-x86_64 /sui/sui

echo 'export PATH="/sui:$PATH"' >> $HOME/.bashrc

echo "Sui installation completed. Please run 'source $HOME/.bashrc' to update the PATH."
