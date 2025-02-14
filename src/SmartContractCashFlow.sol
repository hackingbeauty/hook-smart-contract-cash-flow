// SPDX-License-Identifier: MIT
pragma solidity 0.8.29;

import {BaseHook} from "v4-periphery/src/utils/BaseHook.sol";
import {IPoolManager} from "v4-core/interfaces/IPoolManager.sol";
import {ERC1155} from "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import {Hooks} from "v4-core/libraries/Hooks.sol";
import {PoolId, PoolIdLibrary} from "v4-core/types/PoolId.sol";
import {PoolKey} from "v4-core/types/PoolKey.sol";
import {Currency, CurrencyLibrary} from "v4-core/types/Currency.sol";
import {StateLibrary} from "v4-core/libraries/StateLibrary.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {TickMath} from "v4-core/libraries/TickMath.sol";
import {BalanceDelta} from "v4-core/types/BalanceDelta.sol";
import {FixedPointMathLib} from "solmate/src/utils/FixedPointMathLib.sol";

contract SmartContractCashFlow is BaseHook, ERC1155 {
    // Constructor
    constructor() {}

    // BaseHook Functions
    function getHookPermissions() public pure override returns (Hooks.Permissions memory) {
        return Hooks.Permissions({
            beforeInitialize: false,
            afterInitialize: true,
            beforeAddLiquidity: false,
            afterAddLiquidity: true,
            beforeRemoveLiquidity: false,
            afterRemoveLiquidity: false,
            beforeSwap: false,
            afterSwap: false,
            beforeDonate: false,
            afterDone: false,
            beforeSwapReturnDelta: false,
            afterSwapReturnDelta: false,
            afterAddLiquidityReturnDelta: false,
            afterRemoveLiquidityReturnDelta: false
        }); 
    }

    function afterAddLiquidity(
        address sender,
        PoolKey calldata key,
        IPoolManager.SwapParams calldata params,
        BalanceDelta,
        bytes calldata
    ) external override onlyPoolManager returns (bytes4, int128) {
        return (this.afterAddLiquidity.selector, 0);
    }

    function lockCollateral() internal returns() {
        // uint daiTokens = IMakerDAO(makerDAOAddr).depositCollateral(liquidity);
    } 


    function swapDaiForETH() internal returns () {
        // IUniswapV3Router03(routerAddr).swap(daiTokens);
    }

    function stakeETH() internal returns () {
        // Beacon deposit contract: https://etherscan.io/address/0x00000000219ab540356cBB839Cbe05303d7705Fa#code
    }

    function withdrawLiquidity() external returns() {

    }

}

    // deposit liquidity into Uniswap
    // take liquidity tokens and deposit as collateral into MakerDAO for DAI
    // go back to Uniswap and swap DAI for ETH
    // take ETH and state into a validator (do you need 32 ETH?)
    // this process should be tokenized

    // now when you go to withdraw your token...it should get you back the rewards
    // rewards in the form of what?

    // step 1 - uint liquidity = IUniswapV3Router03(routerAddr).addLiquidity();
    // step 2 - uint daiTokens = IMakerDAO(makerDAOAddr).depositCollateral(liquidity);
    // step 3 - uint ethTokens = IUniswapV3Router03(routerAddr).swap(daiTokens);

    // Staking URLS:
    // https://www.staking.directory/
    // https://docs.rocketpool.net/guides/staking/overview
    // https://help.lido.fi/en/collections/2947324-staking-with-lido
    // https://solidity-by-example.org/defi/staking-rewards/
