#!/bin/bash

# 默认版本
DEFAULT_VERSION="v1.15.1"

echo "默认安装版本：${DEFAULT_VERSION}"
echo "如果需要安装其他版本，请在 https://github.com/MystenLabs/sui/releases/ 下载"
echo "下载对应版本后，在压缩包所在目录重新运行此脚本。"

PATTERN="sui-mainnet-*-ubuntu-x86_64.tgz"

MATCHING_FILES=$(ls $PATTERN 2> /dev/null | head -n 1)

if [ ! -z "$MATCHING_FILES" ]; then
    echo "检测到文件 $MATCHING_FILES，将会使用此文件进行安装。"
    tar xzf "$MATCHING_FILES"
else
    echo "未检测到文件，正在下载默认版本 ${DEFAULT_VERSION}。"
    FILENAME="sui-mainnet-${DEFAULT_VERSION}-ubuntu-x86_64.tgz"
    if ! curl -L "https://github.com/MystenLabs/sui/releases/download/mainnet-${DEFAULT_VERSION}/${FILENAME}" | tar xz; then
        echo "下载失败，请检查网络连接或手动下载：https://github.com/MystenLabs/sui/releases/"
        echo "下载完成后，请将压缩包放置在脚本同级目录并重新运行脚本。"
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

rm -rf ./target
rm -rf ./external-crates

echo "Sui installation completed. Please run 'source $HOME/.bashrc' to update the PATH."
