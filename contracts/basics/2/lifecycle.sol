// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

contract lifecycle{


enum Stage{infant, toddler, child, teenager, adult, old}


    function getstage(uint months) public pure returns(Stage) {
        if (months > 0 && months <= 12)
        return Stage.infant;
                else if(months > 12 && months <= 24)
            return Stage.toddler;
        else if(months > 24 && months <= 155)
            return Stage.child;
        else if(months > 156 && months <= 228)
            return Stage.teenager;
        else if(months > 228 && months <= 720)
            return Stage.adult;
        else
            return Stage.old;
    }
}