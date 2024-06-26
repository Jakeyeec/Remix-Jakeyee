//SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;


import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

contract FundMe {

    address[] public fundedAddress;

    mapping(address fundAddress => uint256 AmountFunded) addressAmountOfFunding;

    uint256 public minimumUsd = 5 * 1e18;
    function fund() public payable {
        require(totalPrice(msg.value) >= minimumUsd, "did not sent enough ETh");
        fundedAddress.push(msg.sender);
        addressAmountOfFunding[msg.sender] = addressAmountOfFunding[msg.sender] + msg.value;

    }

    function getPrice() public view returns(uint256) {
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        (,int256 price,,,) = priceFeed.latestRoundData();
        return uint256(price * 1e10);
        
        
    }

    function totalPrice(uint256 numberOfEth) public view returns(uint256) {
        uint256 ethPrice = getPrice();
        uint256 tPrice = (ethPrice * numberOfEth) / 1e18;
        return tPrice;
    }
}