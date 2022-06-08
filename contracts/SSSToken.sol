// SPDX-License-Identifier: None

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";


contract SSSToken is ERC20, Ownable {

using SafeMath for uint256;
uint256 private  _decimals = 18;
uint256 private  _cap = 10000 * (10 ** _decimals); 
uint256 public _totalSupply;

    constructor () ERC20 ("SSSToken", "SSS") {
      uint256 initialSupply = 1000;
      
      _mint(msg.sender, initialSupply);
         _totalSupply = initialSupply;
    }

      function mint(address account, uint256 amount) external onlyOwner  {
      require(_totalSupply.add(amount) <= _cap, "ERC20: cap exceeded");

      _totalSupply += amount;
      _mint(account, amount);
  }



    
}

