// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

// IERC20 arayüzü ve SafeERC20 yardımcı kütüphanesi OpenZeppelin'den ithal ediliyor
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/**
 * @title WinnerList
 * @dev Bu kontrat, bir admin tarafından belirli adreslere ERC20 token airdrop'u yapılmasını sağlar.
 */
contract WinnerList is Ownable {
    using SafeERC20 for IERC20;

    /// @notice Airdrop yapılacak olan token adresi
    IERC20 public token;

    /**
     * @dev Kontratı başlatır ve airdrop yapılacak token adresini belirler.
     * @param _token Airdrop yapılacak token adresi
     */
    constructor(address _token) {
        require(_token != address(0), "Token address cannot be zero.");
        token = IERC20(_token);
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
    function setToken(address _token) external onlyOwner {
        require(_token != address(0), "Token address cannot be zero.");
        token = IERC20(_token);
    }
}
