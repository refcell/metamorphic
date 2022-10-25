// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

/// @title Metamorphic Contract Factory Interface
/// @notice An interface to the factory contract that holds a reference to the
/// initialization code that will be used by the transient contract to deploy
/// the metamorphic contract.
interface FactoryInterface {
    /// @notice Returns the address of the initialization code that will be used
    function getInitializationCode() external view returns (bytes memory initializationCode);

    /// @notice Returns the implementation address that will be used
    function getImplementation() external view returns (address implementation);

    /// @notice Returns the address of the implementation that will be used
    function getImplementationContractAddress(address metamorphicContractAddress) external view returns (
        address implementationContractAddress
    );

}
