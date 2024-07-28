// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/IERC20.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/utils/SafeERC20.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";

/**
 * @title AirdropContract
 * @dev Bu kontrat, belirli adreslere ERC20 token airdrop'u yapılmasını sağlar.
 */
contract AirdropContract is Ownable {
    using SafeERC20 for IERC20;

    /// @notice Airdrop yapılacak token adresi
    IERC20 public token;

    /**
     * @dev Kontratı başlatır ve airdrop yapılacak token adresini belirler.
     * @param _token Airdrop yapılacak token adresi
     */
    constructor(IERC20 _token) Ownable(msg.sender) {
        require(address(_token) != address(0), "Token address cannot be zero.");
        token = _token;
    }

    /**
     * @notice Admin tarafından belirlenen adreslere airdrop yapar.
     * @dev Sadece admin bu işlemi gerçekleştirebilir.
     * @param recipients Airdrop yapılacak adreslerin listesi
     * @param amounts Her bir adres için airdrop miktarlarının listesi
     */
    function airdrop(address[] calldata recipients, uint256[] calldata amounts) external onlyOwner {
        require(recipients.length == amounts.length, "Recipients and amounts length mismatch.");
        
        // Airdrop yapılacak adreslere token gönderimi
        for (uint256 i = 0; i < recipients.length; i++) {
            token.safeTransfer(recipients[i], amounts[i]);
        }
    }

    /**
     * @notice Token adresini günceller.
     * @dev Sadece admin bu işlemi gerçekleştirebilir.
     * @param _token Yeni token adresi
     */
    function setToken(IERC20 _token) external onlyOwner {
        require(address(_token) != address(0), "Token address cannot be zero.");
        token = _token;
    }
}
