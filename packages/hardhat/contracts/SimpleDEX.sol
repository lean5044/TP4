// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

// ETH Kipu TP4
// Autor L.N.R.

/**
Se despliegan los contratos con las modificaciones propuestas por el profesor. 
Se utiliza Scaffold-eth para la interfaz grafica
**/


import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol"; // IMPLEMENTACION DE RECOMENDACION DEL PROFESOR


contract SimpleDEX is Ownable {

    address owner;
    IERC20 public tokenA;
    IERC20 public tokenB;
    uint256 public amountA;
    uint256 public amountB;

    uint256 public Ao;
    uint256 public Bo;
    uint256 public dA;
    uint256 public dB;
    uint256 public price;


    constructor(address _tokenA, address _tokenB) 
    Ownable(msg.sender)
    { 
        // MEJORA RECOMENDADA POR EL PROFESOR
        // owner = msg.sender; // Seteo el owner como el que deploya el contrato

        tokenA = IERC20 (_tokenA);
        tokenB = IERC20 (_tokenB);
    }

    // MODIFICADORES
    // SE COMENTA EL MODIFICADOR POR MEJORA RECOMENDADA POR EL PROFESOR
    // modifier onlyOwner {
    //     require(msg.sender == owner, "Solo el owner puede ejecutar esta funcion");
    //     _;
    // }

    // FUNCIONES SOLICITADAS

    function addLiquidity(uint256 _amountA, uint256 _amountB) public onlyOwner {
        amountA = _amountA;
        amountB = _amountB;
    
    // Cuando agrego liquidez tengo que hacerlo en pares.
        tokenA.transferFrom(msg.sender, address(this), amountA);
        tokenB.transferFrom(msg.sender, address(this), amountB);

    }
    function removeLiquidity(uint256 _amountA, uint256 _amountB) public onlyOwner {
        amountA = _amountA;
        amountB = _amountB;
    // Saco del pool de liquidez y se lo devuelvo al owner
        tokenA.transfer(msg.sender, amountA);
        tokenB.transfer(msg.sender, amountB);
    }

    function swapAforB(uint256 amountAIn) public { 
        // Utilizo la formula de liquidez continua 
        // dY = Yo - (Xo * Yo) / (Xo + dX)
        // Xo => Ao
        // Yo => Bo
        // dB = Bo - (Ao * Bo) / (Ao + dA)
        dA = amountAIn;
        Ao = tokenA.balanceOf(address(this));
        Bo = tokenB.balanceOf(address(this));
        dB = Bo - (Ao * Bo) / (Ao + dA);

        tokenB.transferFrom(msg.sender, address(this), dB);
        
        
    }
    function swapBforA(uint256 amountBIn) public {
        // Utilizo la formula de liquidez continua
        // dX = (Xo * Yo) / (Yo - dY) - Xo
        // Ao = Xo
        // Bo = Yo
        // dA = (Ao * Bo) / (Bo - dB) - Ao
        dB = amountBIn;
        Ao = tokenA.balanceOf(address(this));
        Bo = tokenB.balanceOf(address(this));
        dA = (Ao * Bo) / (Bo - dB) - Ao;

        tokenA.transferFrom(msg.sender, address(this), amountA);    
    
    }
    function getPrice(address _token) public { 
        // Utilizo la formula de precio
        // Precio A = Cantidad de B / Cantidad de A

        Ao = tokenA.balanceOf(address(this)); // Cantidad de A
        Bo = tokenB.balanceOf(address (this)); // Cantidad de B
        // if (IERC20(_token) ==  tokenA)
        if(_token == address(tokenA)){
            price = Bo / Ao;
        } else if (_token == address(tokenB)){
            price = Ao / Bo;
        } else revert("No se encuentra el token solicitado");
        
        price = price * 10**2; // Multiplico por la cantidad de decimales (dos en el caso de los Tokens)

    }

}
