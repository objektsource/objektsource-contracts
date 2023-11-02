// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Pausable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/cryptography/EIP712.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Votes.sol";

/*
_____ _____    __ _____ _____ _____
|     | __  |__|  |   __|  |  |_   _|
|  |  | __ -|  |  |   __|    -| | |
|_____|_____|_____|_____|__|__| |_|
_____ _____ _____ _____ _____ _____
|   __|     |  |  | __  |     |   __|
|__   |  |  |  |  |    -|   --|   __|
|_____|_____|_____|__|__|_____|_____|
@title ObjektSource
@author @mikhailusov
*/
contract ObjektSource is ERC721, ERC721Pausable, Ownable, EIP712, ERC721Votes {
    uint256 private _nextTokenId;

    constructor(address initialOwner)
        ERC721("ObjektSource", "OBJSRC")
        Ownable(initialOwner)
        EIP712("ObjektSource", "1")
    {}

    function pause() public onlyOwner {
        _pause();
    }

    function unpause() public onlyOwner {
        _unpause();
    }

    function safeMint(address to) public onlyOwner {
        uint256 tokenId = _nextTokenId++;
        _safeMint(to, tokenId);
    }

    // The following functions are overrides required by Solidity.

    function _update(address to, uint256 tokenId, address auth)
        internal
        override(ERC721, ERC721Pausable, ERC721Votes)
        returns (address)
    {
        return super._update(to, tokenId, auth);
    }

    function _increaseBalance(address account, uint128 value)
        internal
        override(ERC721, ERC721Votes)
    {
        super._increaseBalance(account, value);
    }
}
