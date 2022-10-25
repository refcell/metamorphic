// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

import { Test } from "forge-std/Test.sol";
import { HuffDeployer } from "foundry-huff/HuffDeployer.sol";
import { IMetamorphicFactory } from "src/interfaces/IMetamorphicFactory.sol";
import { IMetamorph } from "src/interfaces/IMetamorph.sol";

contract MetamorphicFactoryTest is Test {
    IMetamorphicFactory internal factory;

    function setUp() public {
        IExampleClone impl = IExampleClone(HuffDeployer.deploy("ExampleClone"));
        factory = IMetamorphicFactory(
            HuffDeployer.deploy_with_args("MeamorphicFactory", abi.encode(address(impl)))
        );
    }

    // TODO :: Tests

}
