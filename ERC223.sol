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


contract ERC223 is Token {
   //fall back function added in ERC223 
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
        //first we must check that is the _to address is a contract address ?? or not

    }    

    function transfer(address _to, uint256 value, bytes _data) returns (bool success) {
        //first we must check that is the _to address is a contract address ?? or not
        
    }

}