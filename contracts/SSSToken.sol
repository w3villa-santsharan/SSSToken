// SPDX-License-Identifier: None

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";


contract SSSToken is ERC20, Ownable {

using SafeMath for uint256;
uint256 private  _cap = 10000 * (10 ** decimals()); 
mapping (address => uint256) private tokenHoldersIndexes;
address[] public tokenHoldersList;

    constructor () ERC20 ("SSSToken", "SSS") {
      uint256 initialSupply = 100 * (10 ** decimals());
      
      _mint(msg.sender, initialSupply);
    }
      function mint(address account, uint256 amount) external onlyOwner  {
      require(totalSupply().add(amount) <= _cap, "ERC20: cap exceeded");

      _mint(account, amount); 
  }    

  //100000000000000000000

  function transferToken(address from, address to, uint256 amount) external  returns(bool){
        _transfer(from, to, amount);
        _afterTokenTransfer(from, to);
        return true;
    }

  function _afterTokenTransfer(
        address from,
        address to
    ) internal virtual  {

   if(balanceOf(from) > 0 && tokenHoldersIndexes[from] == 0){

       addTokenHolder(from);
       
    }
    
    else if(balanceOf(from) == 0 && tokenHoldersIndexes[from] > 0){
         
      removeTokenHolder(from);
    }

      if(balanceOf(to) > 0 && tokenHoldersIndexes[to] == 0){
       
      addTokenHolder(to);

    }else if(balanceOf(to) == 0 && tokenHoldersIndexes[to] > 0){
       
      removeTokenHolder(to);
    }

    }

    function addTokenHolder(address tokenHolder) internal  {
      tokenHoldersList.push(tokenHolder);
      tokenHoldersIndexes[tokenHolder] = tokenHoldersList.length;
    
    }

    function removeTokenHolder(address tokenHolder) internal  {
      for(uint i = 0; i < tokenHoldersList.length-1; i++){
        if(tokenHoldersList[i]==tokenHolder){
          delete tokenHoldersList[i];
          tokenHoldersIndexes[tokenHolder] = 0;


        }
      }
    }

    function checkExist(address user) external view returns(uint){
      uint ind =  tokenHoldersIndexes[user];
      return ind;
    }
}


