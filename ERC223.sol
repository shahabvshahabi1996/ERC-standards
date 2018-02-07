pragma solidity ^0.4.0;


contract TokenReciver {
    function tokenFallBack(address _from, uint value, bytes _data) {}    
}


contract Token {
    function balanceOf(address _owner) constant returns (uint256 balance);
    function transfer(address _to, uint256 value) returns (bool success);
    function transfer(address _to, uint256 value, bytes _data) returns (bool success);
    event Transfer(address indexed _from, address indexed _to, uint256 _value, bytes _data);
}


contract ERC223 is Token, TokenReciver {
   //fall back function added in ERC223
    mapping (address=>uint) _balanceOf;

    function() payable {
        revert();
    }

    function isContract(address _address) returns(bool) {
        uint length;
        assembly {
            length := extcodesize(_address)
        }
        if (length > 0) {
            return true;
        }else {
            return false;
        }   
    }

    function transfer(address _to, uint256 value) returns (bool success) {
        bytes memory empty;
        if (value > 0 && _balanceOf[msg.sender] > value) {
            _balanceOf[msg.sender] -= value;
            _balanceOf[_to] += value;
            if (isContract(_to)) {
                TokenReciver reciver = TokenReciver(_to);
                reciver.tokenFallBack(msg.sender, value, empty);
            }
            Transfer(msg.sender, _to, value, empty);
            return true;
        }else {
            return false;
        }
    }    

    function transfer(address _to, uint256 value, bytes _data) returns (bool success) {
        bytes memory empty;
        if (value > 0 && _balanceOf[msg.sender] > value) {
            _balanceOf[msg.sender] -= value;
            _balanceOf[_to] += value;
            if (isContract(_to)) {
                TokenReciver reciver = TokenReciver(_to);
                reciver.tokenFallBack(msg.sender, value, _data);
            }
            Transfer(msg.sender, _to, value, _data);
            return true;
        }else {
            return false;
        }
    }
}