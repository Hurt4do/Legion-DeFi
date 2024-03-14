//SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

// Useful for debugging. Remove when deploying to a live network.
import "hardhat/console.sol";


contract Legion {
    // Registro de balances en Ether de cada dirección
    mapping(address => uint256) public balances;

    // Eventos para depositar y retirar
    event DepositMade(address indexed account, uint amount);
    event WithdrawalMade(address indexed account, uint amount);

    // Función para depositar Ether en el contrato
    function deposit() public payable {
        require(msg.value > 0, "Deposit amount must be greater than 0");
        balances[msg.sender] += msg.value;
        emit DepositMade(msg.sender, msg.value);
    }

    // Función para retirar Ether del contrato
    function withdraw(uint256 amount) public {
        require(amount <= balances[msg.sender], "Insufficient funds");
        balances[msg.sender] -= amount;
        payable(msg.sender).transfer(amount);
        emit WithdrawalMade(msg.sender, amount);
    }

    // Función para consultar el balance de Ether depositado en el contrato
    function balance() public view returns (uint256) {
        return balances[msg.sender];
    }

    // Función para recibir Ether cuando se envía directamente al contrato
    receive() external payable {
        deposit();
    }
}
