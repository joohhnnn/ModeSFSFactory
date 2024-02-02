// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v5.0.0/contracts/token/ERC20/ERC20.sol";


contract Register {
    function register(address _recipient) public returns (uint256 tokenId) {}
}

contract ModeToken is ERC20 {

    address feeReceiver = tx.origin;
    
    constructor() ERC20("ModeTokenSFSTest", "SFST2") {
        _mint(tx.origin, 1000 * 10 ** 18); //Example amount to mint our ERC20
        feeReceiver = tx.origin; //The deployer of the contract will get the NFTto widthraw the earned fees
        Register sfsContract = Register(0x8680CEaBcb9b56913c519c069Add6Bc3494B7020); // This address is the address of the SFS contract
        sfsContract.register(tx.origin); //Registers this contract and assigns the NFT to the owner of this contract
    }
}

