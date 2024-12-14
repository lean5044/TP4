// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.0
pragma solidity ^0.8.22;

// ETH Kipu TP4
// Autor L.N.R.

import {ERC20} from "@openzeppelin/contracts@5.1.0/token/ERC20/ERC20.sol";
import {Ownable} from "@openzeppelin/contracts@5.1.0/access/Ownable.sol";

contract TokenA is ERC20, Ownable {
    constructor()
        ERC20("TokenA", "TKA")
        Ownable(msg.sender) // El owner va a ser el EOA que despliega el contrato
    {
        _mint(msg.sender, 10000 * 10 ** decimals()); // Minteo para el owner 10000 tokens
    }

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

    function decimals() public pure override  returns (uint8) {
        return 2; // Modifico la funcion para que tenga solo 2 decimales para conveniencia del TP
    }


}
