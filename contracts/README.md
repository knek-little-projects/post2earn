# POST2EARN

## Deployments

| Chain | Contract | Address |
|-|-|-|
BASE | Hook TransparentUpgradeableProxy |   0x5Bd6b35110ab9E18BF005C11f29eAE6F42B6EB44
BASE | ProxyAdmin |                         0x077ccE0a08D7cbA9a71737C39EAf035b2d784C1A
BASE | Hook impl v1 |                       0x806fc688e8302D9D8e6E7785F6fFC2a77c133a23
BASE | Hook impl v2 | 

## Foundry

**Foundry is a blazing fast, portable and modular toolkit for Ethereum application development written in Rust.**

Foundry consists of:

-   **Forge**: Ethereum testing framework (like Truffle, Hardhat and DappTools).
-   **Cast**: Swiss army knife for interacting with EVM smart contracts, sending transactions and getting chain data.
-   **Anvil**: Local Ethereum node, akin to Ganache, Hardhat Network.
-   **Chisel**: Fast, utilitarian, and verbose solidity REPL.

## Documentation

https://book.getfoundry.sh/

## Usage

### Build

```shell
$ forge build
```

### Test

```shell
$ forge test
```

### Format

```shell
$ forge fmt
```

### Gas Snapshots

```shell
$ forge snapshot
```

### Anvil

```shell
$ anvil
```

### Deploy

```shell
$ forge script script/Counter.s.sol:CounterScript --rpc-url <your_rpc_url> --private-key <your_private_key>
```

### Cast

```shell
$ cast <subcommand>
```

### Help

```shell
$ forge --help
$ anvil --help
$ cast --help
```
