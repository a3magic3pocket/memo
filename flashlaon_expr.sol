```
// SPDX-License-Identifier: MIT
pragma solidity 0.8.10;

import "https://github.com/aave/aave-v3-core/blob/master/contracts/flashloan/base/FlashLoanSimpleReceiverBase.sol";
import "https://github.com/aave/aave-v3-core/blob/master/contracts/interfaces/IPoolAddressesProvider.sol";
import "https://github.com/aave/aave-v3-core/blob/master/contracts/misc/AaveProtocolDataProvider.sol";
import "https://github.com/aave/aave-v3-core/blob/master/contracts/protocol/libraries/types/DataTypes.sol";
import "https://github.com/aave/aave-v3-core/blob/master/contracts/dependencies/openzeppelin/contracts/IERC20.sol";
import "https://github.com/aave/aave-v3-core/blob/master/contracts/dependencies/openzeppelin/contracts/IERC20Detailed.sol";

interface IFaucet {
    function mint(
        address _token,
        uint256 _amount
    ) external;
}

contract SimpleFlashLoan is FlashLoanSimpleReceiverBase {
    address payable owner;

    // IFaucet public immutable FAUCET;

    constructor(address _addressProvider)
        FlashLoanSimpleReceiverBase(IPoolAddressesProvider(_addressProvider))
    {
        owner = payable(msg.sender);
        // FAUCET = IFaucet(0x1f885520b7BD528E46b390040F12E753Dce43004);
    }

    event intLog(string name, uint256 value);
    event memoryBytesLog(bytes value);
    event getReserveDataLog(DataTypes.ReserveData);

    function fn_RequestFlashLoan(address _token, uint256 _amount) public {
        address receiverAddress = address(this);
        address asset = _token;
        uint256 amount = _amount;
        bytes memory params = "";
        uint16 referralCode = 0;

        emit intLog('FLASHLOAN_PREMIUM_TOTAL', POOL.FLASHLOAN_PREMIUM_TOTAL());
        emit intLog('FLASHLOAN_PREMIUM_TO_PROTOCOL', POOL.FLASHLOAN_PREMIUM_TO_PROTOCOL());

        DataTypes.ReserveData memory result = POOL.getReserveData(asset);
        emit getReserveDataLog(result);
        emit intLog('result.aTokenAddress.totalSupply', IERC20Detailed(result.aTokenAddress).totalSupply());
        emit intLog('stableDebtTokenAddress.totalSupply', IERC20Detailed(result.stableDebtTokenAddress).totalSupply());
        emit intLog('variableDebtTokenAddress.totalSupply', IERC20Detailed(result.variableDebtTokenAddress).totalSupply());
        emit intLog('result.liquidityIndex', result.liquidityIndex);
        

        POOL.flashLoanSimple(
            receiverAddress,
            asset,
            amount,
            // IERC20Detailed(result.aTokenAddress).totalSupply(),
            // params,
            '0x10',
            referralCode
        );

        address[] memory hello = new address[](1); 
        hello[0] = asset;

        POOL.mintToTreasury(hello);

        result = POOL.getReserveData(asset);
        emit getReserveDataLog(result);
    }
    
        //This function is called after your contract has received the flash loaned amount

    function executeOperation(
        address asset,
        uint256 amount,
        uint256 premium,
        address initiator,
        bytes calldata params
    )  external override returns (bool) {
        
        //Logic goes here
        

        // FAUCET.mint(asset,premium);
        uint256 totalAmount = amount + premium;
        IERC20(asset).approve(address(POOL), totalAmount);

        return true;
    }

    function getBalance(address _tokenAddress) external view returns (uint256) {
        return IERC20(_tokenAddress).balanceOf(address(this));
    }

    function withdraw(address _tokenAddress) external onlyOwner {
        IERC20 token = IERC20(_tokenAddress);
        token.transfer(msg.sender, token.balanceOf(address(this)));
    }

    modifier onlyOwner() {
        require(
            msg.sender == owner,
            "Only the contract owner can call this function"
        );
        _;
    }

    receive() external payable {}
}
```