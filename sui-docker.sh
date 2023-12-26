#!/bin/bash

docker pull mysten/sui-tools:devnet

docker run --name suidevcontainer -itd mysten/sui-tools:devnet

docker exec -it suidevcontainer bash
