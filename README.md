## Foundry

**Foundry is a blazing fast, portable and modular toolkit for Ethereum application development written in Rust.**

Foundry consists of:

- **Forge**: Ethereum testing framework (like Truffle, Hardhat and DappTools).
- **Cast**: Swiss army knife for interacting with EVM smart contracts, sending transactions and getting chain data.
- **Anvil**: Local Ethereum node, akin to Ganache, Hardhat Network.
- **Chisel**: Fast, utilitarian, and verbose solidity REPL.

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

forge install openzeppelin/openzeppelin-contracts
https://gitlab.com/hoanghoo/ethernaut-foundry/-/blob/main/test/1_Fallback.t.sol?ref_type=heads
https://github.com/az0mb13/ethernaut-foundry/blob/master/instances/Ilevel01.sol

https://github.com/Simon-Busch/Foundry-ethernaut-solutions/tree/main/test
https://ethernaut.openzeppelin.com/level/0xb2aBa0e156C905a9FAEc24805a009d99193E3E53
