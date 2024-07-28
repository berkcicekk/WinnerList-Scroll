// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/**
 * @berk-elfreud
 * @WinnerList Airdrop Portal Scroll Contrat
 */
contract AirdropContract is Ownable {
    using SafeERC20 for IERC20;

    /// @notice Airdrop yapılacak token adresi
    IERC20 public token;

    /**
     * @dev Kontratı başlatır ve airdrop yapılacak token adresini belirler.
     * @param _token Airdrop yapılacak token adresi
     */
    constructor(IERC20 _token) {
        require(address(_token) != address(0), "Token address cannot be zero.");
        token = _token;
    }

    /**
     * @notice Admin tarafından belirlenen adreslere airdrop yapar.
     * @dev Sadece admin bu işlemi gerçekleştirebilir.
     * @param recipients Airdrop yapılacak adreslerin listesi
     * @param amounts Her bir adres için a
