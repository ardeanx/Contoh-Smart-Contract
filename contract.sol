// Versi
pragma solidity ^0.8.14;

// Class Contract
contract Cloud {

    // Variabel
    mapping(address => uint) public balances;

    // Detail Token
    string public name = "Nama Token";
    string public symbol = "Simbol Token";
    uint public totalSupply = 1000000 * 10 ** 18;
    uint public decimals = 18;

    // Events
    event Transfer(address indexed from, address indexed to, uint value);
    event Approval(address indexed owner, address indexed spender, uint value);

    // Pemetaan untuk menyimpan Dana
    mapping(address => mapping(address => uint)) public allowance;

    // Fungsi Constructor
    constructor() {
        balances[msg.sender] = totalSupply;
    }

    // Fungsi untuk mendapatkan Saldo
    function balanceOf(address owner) public view returns(uint) {
        return balances[owner];
    }

    // Fungsi untuk mentransfer token dari satu alamat ke alamat lainnya
    function transferFrom(address from, address to, uint value) public returns(bool) {
        require(balanceOf(from) >= value, 'Saldo anda kurang');
        require(allowance[from][msg.sender] >= value, 'Dana anda kurang');
        balances[to] += value;
        balances[from] -= value;
        emit Transfer(from, to, value);
        return true;
    }

    // Fungsi untuk Approve token
    function approve(address spender, uint value) public returns(bool) {
        allowance[msg.sender][spender] = value;
        emit Approval(msg.sender, spender, value);
        return true;
    }
}
