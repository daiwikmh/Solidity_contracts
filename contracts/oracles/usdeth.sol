// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

contract EtherUSDPrice {
    
        AggregatorV3Interface internal dataFeed;

        constructor() {
            dataFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        }

        function getPrice() public view returns(int){
            (,int price,,,) = dataFeed.latestRoundData();
            return price;
        }
    }
