// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {PriceConvertor} from "./priceConvertor.sol";


contract fundMe {
    address public owner;

    constructor(){
        owner = msg.sender;
    }

    using PriceConvertor for uint256;

    uint256 public minimumUsd = 5e18;
    address[] public funders;
    mapping(address funder => uint256 amoutFunded) public addressToAmountFunded;

    

    function fund() public payable{
        
        require(msg.value.getConvertionRate() > minimumUsd, "NOPE");
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] += msg.value;
    }

    function withdraw() public { 
        for(uint256 funderIndex = 0; funderIndex < funders.length; funderIndex++){
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0;

        }
        funders = new address[](0);
        (bool callSuccess, ) = payable(msg.sender).call{value: address(this).balance}("");
        require(callSuccess, "noipe");
    
    }

    modifier onlyOwner() {
        //_;
        require(msg.sender == owner,"nope no");
        _;
        //order of _ matters


    }

}
