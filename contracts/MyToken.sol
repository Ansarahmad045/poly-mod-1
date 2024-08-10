// SPDX-License-Identifier: MIT

pragma solidity ^0.8.9;

import "erc721a/contracts/ERC721A.sol";

contract MyToken is ERC721A {
    address public contractOwner;

    uint256 public maximumMintQuantity = 5;

    // here you can also use your own baseurl
    string internal baseTokenURI =
        "https://indigo-immense-barnacle-223.mypinata.cloud/ipfs/QmYAguVHDGpTpHTP1bpG9VmVhZHJt5RHQii4TvAxbCWUqo/";

    string public descriptionPrompt = "not me";

    constructor() ERC721A("MyToken", "m") {
        contractOwner = msg.sender;
    }

    modifier onlyContractOwner() {
        require(msg.sender == contractOwner, "Only the contract owner can perform this action!");
        _;
    }

    function mintTokens(uint256 quantity) external payable onlyContractOwner {
        require(
            totalSupply() + quantity <= maximumMintQuantity,
            "You cannot mint more than 5 tokens"
        );
        _mint(msg.sender, quantity);
    }

    function _baseURI() internal view override returns (string memory) {
        return baseTokenURI;
    }

    function getDescriptionPrompt() external view returns (string memory) {
        return descriptionPrompt;
    }
}
