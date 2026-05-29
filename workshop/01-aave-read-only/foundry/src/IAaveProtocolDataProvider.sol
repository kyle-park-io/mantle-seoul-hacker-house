// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

/// @notice Minimal interface for Aave V3 AaveProtocolDataProvider — only the
///         read-only methods this demo uses.
/// Source ABI: contracts/aave-v3-mantle/abi/AaveProtocolDataProvider.json
/// Deployed (Mantle): 0x487c5c669D9eee6057C44973207101276cf73b68
interface IAaveProtocolDataProvider {
    // Key fields used by the demo:
    //   totalAToken        — total supplied (aToken supply)
    //   totalVariableDebt  — total variable-rate debt
    //   liquidityRate      — current supply APR, ray (1e27)
    //   variableBorrowRate — current variable borrow APR, ray (1e27)
    //   lastUpdateTimestamp — last reserve update
    function getReserveData(address asset)
        external
        view
        returns (
            uint256 unbacked,
            uint256 accruedToTreasuryScaled,
            uint256 totalAToken,
            uint256 totalStableDebt, // unused in V3, always 0
            uint256 totalVariableDebt,
            uint256 liquidityRate,
            uint256 variableBorrowRate,
            uint256 stableBorrowRate, // unused in V3
            uint256 averageStableBorrowRate, // unused in V3
            uint256 liquidityIndex,
            uint256 variableBorrowIndex,
            uint40 lastUpdateTimestamp
        );

    // Returns: decimals, ltv, liquidationThreshold, liquidationBonus,
    //          reserveFactor, then collateral/borrow/active/frozen flags.
    function getReserveConfigurationData(address asset)
        external
        view
        returns (
            uint256 decimals,
            uint256 ltv,
            uint256 liquidationThreshold,
            uint256 liquidationBonus,
            uint256 reserveFactor,
            bool usageAsCollateralEnabled,
            bool borrowingEnabled,
            bool stableBorrowRateEnabled,
            bool isActive,
            bool isFrozen
        );
}
