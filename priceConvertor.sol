// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

library PriceConvertor {
    function getPriceUsd() internal view returns (uint256) {
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        (,int256 awnser,,,)= priceFeed.latestRoundData();
        return uint256(awnser * 1e10);
    }
    
    function getConvertionRate(uint256 ethAmout) internal view returns(uint256) {
        uint256 ethPtice = getPriceUsd();
        uint256 ethAmountInUsd = (ethPtice * ethAmout) / 1e18;
        return ethAmountInUsd;
    }
}
