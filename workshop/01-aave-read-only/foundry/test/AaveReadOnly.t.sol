// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import {Test, console} from "forge-std/Test.sol";
import {IAaveProtocolDataProvider} from "src/IAaveProtocolDataProvider.sol";

/// @notice Reads live Aave V3 reserve state for USDC on a Mantle mainnet fork.
///         Pure read-only — no broadcast, no state mutation.
///
/// Addresses: contracts/aave-v3-mantle/address.md
/// Run: forge test --fork-url $MANTLE_RPC_URL -vv
///      (falls back to public RPC if MANTLE_RPC_URL is unset)
contract AaveReadOnlyForkTest is Test {
    // Aave V3 Mantle (proto_mantle_v3)
    IAaveProtocolDataProvider constant DATA_PROVIDER =
        IAaveProtocolDataProvider(0x487c5c669D9eee6057C44973207101276cf73b68);

    // USDC reserve underlying
    address constant USDC = 0x09Bc4E0D864854c6aFB6eB9A9cdF58aC190D0dF9;

    // Aave rates are in ray (1e27). APR% = rate * 100 / 1e27.
    uint256 constant RAY = 1e27;

    function setUp() public {
        string memory rpcUrl = vm.envOr("MANTLE_RPC_URL", string("https://rpc.mantle.xyz"));
        vm.createSelectFork(rpcUrl);
    }

    function test_ReadsUsdcReserveData() public view {
        (
            ,
            ,
            uint256 totalAToken,
            ,
            uint256 totalVariableDebt,
            uint256 liquidityRate,
            uint256 variableBorrowRate,
            ,
            ,
            ,
            ,
        ) = DATA_PROVIDER.getReserveData(USDC);

        // ray -> basis points (1% = 100 bp) for readable logging without decimals
        uint256 supplyAprBp = (liquidityRate * 10_000) / RAY;
        uint256 borrowAprBp = (variableBorrowRate * 10_000) / RAY;

        console.log("=== Aave V3 USDC reserve (Mantle) ===");
        console.log("total supplied (aToken, 6dp):", totalAToken);
        console.log("total variable debt   (6dp):", totalVariableDebt);
        console.log("supply APR (bp):", supplyAprBp);
        console.log("borrow APR (bp):", borrowAprBp);

        // Sanity: an active reserve should have supply, and borrow APR >= supply APR.
        assertGt(totalAToken, 0, "USDC reserve should have supply");
        assertGe(variableBorrowRate, liquidityRate, "borrow rate should be >= supply rate");
    }

    function test_ReadsUsdcConfiguration() public view {
        (
            uint256 decimals,
            uint256 ltv,
            uint256 liquidationThreshold,
            ,
            uint256 reserveFactor,
            bool usageAsCollateralEnabled,
            bool borrowingEnabled,
            ,
            bool isActive,
            bool isFrozen
        ) = DATA_PROVIDER.getReserveConfigurationData(USDC);

        console.log("=== Aave V3 USDC config (Mantle) ===");
        console.log("decimals:", decimals);
        console.log("LTV (bp):", ltv);
        console.log("liq. threshold (bp):", liquidationThreshold);
        console.log("reserve factor (bp):", reserveFactor);
        console.log("collateral enabled:", usageAsCollateralEnabled);
        console.log("borrowing enabled:", borrowingEnabled);

        assertEq(decimals, 6, "USDC has 6 decimals");
        assertTrue(isActive, "reserve must be active");
        assertFalse(isFrozen, "reserve must not be frozen");
        assertLe(ltv, liquidationThreshold, "LTV must be <= liquidation threshold");
    }
}
