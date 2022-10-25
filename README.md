<img align="right" width="150" height="150" top="100" src="./assets/metamorphic.jpg">

# metamorphic ![tests](https://img.shields.io/github/workflow/status/abigger87/metamorphic/ci/main?label=tests) ![license](https://img.shields.io/github/license/abigger87/metamorphic?label=License) ![solidity](https://img.shields.io/badge/solidity-^0.8.15-lightgrey) ![huff](https://img.shields.io/badge/huff-0.3.0-8b6c5c)

[Huff](https://github.com/huff-language) Smart Contracts for creating Metamorphic (or "redeployable") EVM Contracts.

> **Note**
> This is a rewrite of [0age](https://github.com/0age)'s [metamorphic contracts](https://github.com/0age/metamorphic) in [Huff](https://github.com/huff-language).


### A Trip Down Ethereum History

Prior to [EIP-1014](https://eips.ethereum.org/EIPS/eip-1014) (included in the Constantinople hard fork), contracts on ethereum were _completely_ immutable. Code deployed to a given address could only be created and subsequently destroyed using the `CREATE` and `SELFDESTRUCT` opcodes. Migrating contracts involved replaying state onto a new contract, which is expensive and not scalable.

Fortunately, [EIP-1014](https://eips.ethereum.org/EIPS/eip-1014) introduced the `CREATE2` opcode, a form of ["wild magic"](https://medium.com/@jason.carver/defend-against-wild-magic-in-the-next-ethereum-upgrade-b008247839d2) allowing a contract to be **redeployed to the same address with different bytecode**.

`CREATE2` uses the **caller’s address**, a supplied **salt** parameter, and the **initialization code** of the contract that is created. Altering any one of these parameters will result in your bytecode being deployed to a completely different contract address.

Cool, so we have completely deterministic, redeployable contracts on Ethereum using `CREATE2`, right?

Well, this fails if the initialization code of the contract is non-deterministic. [0age](https://github.com/0age) presents a simple example: consider a contract that calls into some external contract and uses the variable return data to construct the final bytecode. Then the initialization code is in fact non-deterministic, and `CREATE2` will generate an entirely new address for each time the contract is redeployed if the return data from the external contract changes.








// TODO:


### Usage

**Deploying Metamorphic Contracts**

// TODO:

Clone factory contracts should use the [`HuffCloneLib`](src/HuffCloneLib.huff) library. `CLONE` is the main macro for creating clones.

Contracts intended to be cloned should include [`HuffClone`](src/HuffClone.huff) to get access to the helper macros for reading immutable args.

To see an example usage of the library, check out [`ExampleClone`](src/ExampleClone.huff) and [`ExampleCloneFactory`](src/ExampleCloneFactory.huff).

**Installing as a Foundry Library**

To install with [Foundry](https://github.com/foundry-rs/foundry):

```
forge install abigger87/metamorphic
```

> **Warning**
>
> These contracts are **unaudited** and are not recommended for use in production.
>
> Although contracts have been rigorously reviewed, this is **experimental software** and is provided on an "as is" and "as available" basis.
> We **do not give any warranties** and **will not be liable for any loss** incurred through any use of this codebase.


### Contracts

```txt
.
├─ src
|  ├─ interfaces
|  |  ├─ IImmutableCreate2Factory.sol — 
|  |  ├─ IMetamorphicFactory.sol — 
|  |  └─ IMetapod.sol — 
|  ├─ ImmutableCreate2Factory.huff — 
|  ├─ MetamorphicFactory.huff — 
|  ├─ Metapod.huff — 
|  └─ TransientContract.huff — 
└─ tests
   └─ 🧪🧪🧪
```

### Acknowledgements

- [femplate](https://github.com/0age/metamorphic)
- [huffplate](https://github.com/abigger87/huffplate)
- [forge-std](https://github.com/brockelmore/forge-std)

