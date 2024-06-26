//SPDX-License-Identifier:MIT
pragma solidity ^0.8.18;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

contract priceConverter {

    function getEthPriceInUsd() public view returns (uint256) {
        AggregatorV3Interface priceUsd = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        (,int256 price,,,) = priceUsd.latestRoundData();
        return uint256(price);

    }

    function getPriceInJpy() public view returns(uint256) {
        AggregatorV3Interface priceJpy = AggregatorV3Interface(0x8A6af2B75F23831ADc973ce6288e5329F63D86c6);
        (,int price,,,) = priceJpy.latestRoundData();
        uint256 usdPrice = getEthPriceInUsd();
        uint256 jpyPrice = (1000 * usdPrice) / uint256(price);
        return uint(jpyPrice);}

}