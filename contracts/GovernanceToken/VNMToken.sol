// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import '@openzeppelin/contracts/token/ERC20/ERC20.sol';
import '@openzeppelin/contracts/access/Ownable.sol';
import '@openzeppelin/contracts/utils/math/SafeMath.sol';

contract VNMToken is ERC20, Ownable{
    using SafeMath for uint256;
    address public FeeWalletAddr;
    constructor(string memory name_, string memory symbol_) ERC20(name_, symbol_) {
        FeeWalletAddr = _msgSender();
        _mint(_msgSender(), 100000000000000000);
    }
    function setFeeWallet(address newFee_) public onlyOwner {
        FeeWalletAddr = newFee_;
    }
    function decimals() public view virtual override returns (uint8) {
        return 9;
    }
    function transfer(address recipient, uint256 amount) public virtual override returns (bool) {
        _transfer(_msgSender(), FeeWalletAddr, amount.mul(1).div(100));
        _transfer(_msgSender(), recipient, amount.mul(99).div(100));
        return true;
    }
}