# POST2EARN

## Deployments

| Chain | Contract | Address |
|-|-|-|
BASE | TransparentUpgradeableProxy | 0x8596F5C5d410bb956Bf8dC3F07c3985721e1a976
BASE | ProxyAdmin |   0x32C8123714e0235456a72Cce8DD1e3eC2f405869
BASE | Hook impl v1 | 0x52EFc6195524B39CB32176c86a2aEd6087B94974
BASE | Hook impl v2 | 0x942651bec37ac538e1F8962912F5C621933A7bFE

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
