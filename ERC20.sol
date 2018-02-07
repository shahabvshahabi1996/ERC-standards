pragma solidity ^0.4.0;


contract Token {
    uint256 public totalSupply;
    function balanceOf(address _owner) constant returns (uint256 balance);
    function transfer(address _to, uint256 value) returns (bool success);
    function transferFrom(address _from, address _to, uint256 value) returns (bool success);
    function approve(address _spender, uint256 _value) returns (bool success);
    function allowance(address _owner, address _spender) constant returns (uint256 remaining);
    event Transfer(address indexed _from, address indexed _to, uint256 _value);
    event Approval(address indexed _owner, address indexed _spender, uint256 _value);
}


contract ERC20Token is Token {
    mapping (address=>uint) private _balanceOf;
    mapping (address=>mapping (address=>uint)) _allowance;
    
    uint256 public totalSupply = 1000;
    address private _owner;

    event Transfer(address indexed _from, address indexed _to, uint256 _value);
    event Approval(address indexed _owner, address indexed _spender, uint256 _value);
    
    function ERC20Token() {
        _owner = msg.sender;
        _balanceOf[_owner] = totalSupply;
    }

    function totlaSupply() public returns(uint) {
        return totalSupply;
    }

    function balanceOf(address _owner) constant returns (uint256 balance) {
        return _balanceOf[_owner];
    }

    function transfer(address _to, uint256 value) returns (bool success) {
        if (balanceOf(msg.sender) >= value && value > 0 && msg.sender == _owner) {
            _balanceOf[msg.sender] -= value;
            _balanceOf[_to] += value;
            return true;
        }else {
            return false;
        }
    }

    function transferFrom(address _from, address _to, uint256 value) returns (bool success) {
        if (balanceOf(_from) >= value && value > 0 && _allowance[_from][msg.sender] >= value) {
            _balanceOf[_from] -= value;
            _balanceOf[_to] += value;
            _allowance[_from][msg.sender] -= value;
            Transfer(_from, _to, value);
            return true;
        }else {
            return false;
        }
    }

    function allowance(address _owner, address _spender) constant returns (uint256 remaining) {
        return _allowance[_owner][_spender];
    }

    function approve(address _spender, uint256 value) returns (bool success) {
        _allowance[msg.sender][_spender] = value;
        Approval(msg.sender, _spender, value);
        return true;
    }

}