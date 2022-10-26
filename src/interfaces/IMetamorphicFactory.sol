// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

/// @title Metamorphic Contract Factory Interface
/// @notice An interface to the factory contract that holds a reference to the
/// initialization code that will be used by the transient contract to deploy
/// the metamorphic contract.
interface FactoryInterface {
    /// @notice Deploys a metamorphic contract
    function deployMetamorphicContract(
        bytes32 salt,
        bytes calldata implementationContractInitializationCode,
        bytes calldata metamorphicContractInitializationCalldata
    ) external payable returns (address metamorphicContractAddress);

    /// @notice Deploys a meamorphic contract from a given implementation
    function deployMetamorphicContractFromExistingImplementation(
        bytes32 salt,
        address implementationContract,
        bytes calldata metamorphicContractInitializationCalldata
    ) external payable returns (address metamorphicContractAddress);

    /// @notice Deploys a metamorphic contract with constructor args
    function deployMetamorphicContractWithConstructor(
        bytes32 salt,
        bytes calldata initializationCode
    ) external payable returns (address metamorphicContractAddress);

    /// @notice Returns the implementation address that will be used
    function getImplementation() external view returns (address implementation);

    /// @notice Returns the address of the initialization code that will be used
    function getInitializationCode()
        external
        view
        returns (bytes memory initializationCode);

    /// @notice Returns the address of the implementation that will be used
    function getImplementationContractAddress(
        address metamorphicContractAddress
    ) external view returns (address implementationContractAddress);

    /// @notice Gets the metamorphic contract initialization code
    function getMetamorphicContractInstanceInitializationCode(
        address transientContractAddress
    ) external view returns (bytes memory initializationCode);

    /// @notice Computes the metamorphic contract address
    function findMetamorphicContractAddress(bytes32 salt)
        external
        view
        returns (address metamorphicContractAddress);

    /// @notice Computes the address of the transient contract
    function findTransientContractAddress(bytes32 salt)
        external
        view
        returns (address transientContractAddress);

    /// @notice Computes the metamorphic contract address with constructor
    function findMetamorphicContractAddressWithConstructor(bytes32 salt)
        external
        view
        returns (address metamorphicContractAddress);

    /// @notice Computes the metamoprhic contract address with initialization code
    function getMetamorphicContractInitializationCode()
        external
        view
        returns (bytes memory metamorphicContractInitializationCode);

    /// @notice Computes the initialization code hash for a metamorphic contract
    function getMetamorphicContractInitializationCodeHash()
        external
        view
        returns (bytes32 metamorphicContractInitializationCodeHash);

    /// @notice Retrieves the initialization code of a transient contract
    function getTransientContractInitializationCode()
        external
        view
        returns (bytes memory transientContractInitializationCode);

    /// @notice Computes the keccak256 hash of a transient contract's initialization code
    function getTransientContractInitializationCodeHash()
        external
        view
        returns (bytes32 transientContractInitializationCodeHash);
}
