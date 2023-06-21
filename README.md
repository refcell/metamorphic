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

This is where metamorphic contracts step in. Metamorphic contracts provide a way to create a new contract at the same address with different bytecode, even when the initialization code is non-deterministic. They do this by using an intermediary contract that is deployed to the desired address first. This intermediary contract is designed in such a way that it can be "transformed" into the final contract, allowing the final bytecode to be different from the bytecode of the intermediary contract.

In this project provide metamorphic contracts in Huff, a low-level, stack-based language for Ethereum smart contracts. By using Huff, we aim to provide a more efficient and gas-optimized implementation of metamorphic contracts. The focus is to make it easier for developers to create and manage redeployable contracts on Ethereum. 

### Usage

**Deploying Metamorphic Contracts**

To deploy a metamorphic contract, follow the steps below:

1. **Write your contract**: Create your smart contract that you wish to make redeployable. Be aware of any non-deterministic initialization code, as this can affect the deployment process.

2. **Include the HuffCloneLib**: In your contract, include the `HuffCloneLib` library. This provides the `CLONE` macro which is used to create metamorphic versions of your contract.

3. **Use HuffClone in your contract**: Also include the `HuffClone` in your contract. This provides helper macros for reading immutable args, which are important for the redeployment process.

4. **Create a factory contract**: Create a factory contract that will be responsible for deploying your metamorphic contract. This factory contract should use the `HuffCloneLib` library to create clones of your original contract.

5. **Deploy the factory contract**: Deploy the factory contract onto the Ethereum network. This can be done using your preferred deployment method.

6. **Deploy your metamorphic contract**: Use the factory contract to deploy instances of your metamorphic contract. You can do this by calling the appropriate function in your factory contract.

For a concrete example of how to use these libraries and macros, refer to the `ExampleClone` and `ExampleCloneFactory` contracts in this project.

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

