// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

import "./mode.sol";

contract Factory {
    mapping(address => bool) private hasDeployed;
    mapping(address => bool) public whitelist;
    address public owner;
    address feeReceiver = tx.origin;
    bool limited;
    event ContractDeployed(address indexed deployer, address indexed contractAddress);

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this function");
        _;
    }

    constructor() {
        owner = msg.sender;
        feeReceiver = tx.origin; //The deployer of the contract will get the NFTto widthraw the earned fees
        Register sfsContract = Register(0x8680CEaBcb9b56913c519c069Add6Bc3494B7020); // This address is the address of the SFS contract
        sfsContract.register(msg.sender); //Registers this contract and assigns the NFT to the owner of this contract
    }


    function addToWhitelist(address _address) public onlyOwner {
        whitelist[_address] = true;
    }

    function removeFromWhitelist(address _address) public onlyOwner {
        whitelist[_address] = false;
    }

    function deploy() public {
        if (limited) {
            require(!hasDeployed[msg.sender] || whitelist[msg.sender] || msg.sender == owner, "Address already used, not whitelisted, or not owner");
        }
        ModeToken newContract = new ModeToken();
        hasDeployed[msg.sender] = true;
        emit ContractDeployed(msg.sender, address(newContract));
    }

    function changeLimited() public onlyOwner {
        limited = !limited;
    }
}
