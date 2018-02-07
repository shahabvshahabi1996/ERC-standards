# ERC20 VS ERC223

## What is an ERC?
ERC stands for “Ethereum Request for Comment.” This is Ethereum’s version of a Request for Comments (RFC), a concept devised by the Internet Engineering Task Force. Memos within an RFC contain technical and organizational notes. For ERCs, this includes some technical guidelines for the buildout of the Ethereum network.

This was written by Ethereum developers for the Ethereum community. Thus, the workflow of generating an ERC includes a developer. To create standards for the Ethereum platform, a developer submits an Ethereum Improvement Proposal (EIP). This includes protocol specifications and contract standards. Once that EIP is approved by a committee and finalized, it becomes an ERC. 

## Whats in the ERC-20 Standard? 
The ERC-20 standard includes the following functions:

`totalSupply()`: returns total token supply

`balanceOf(address _owner)`: returns account balance of `_owner`’s account

`transfer(address _to, uint256 _value)`: takes in number `_value` and transfers that amount of tokens to `address _to` and triggers transfer event

`transferFrom(address _from, address _to, uint256 _value)`: transfers `_value` amount of tokens from the `address _from` to the `address _to`, and triggers the `transfer` event

`approve(address _spender, uint256 _value)`: allows `_spender` to withdraw any number up to `_value` amount

`allowance(address _owner, address _spender)`: returns the amount which `the_spender` is still allowed to withdraw from the `_owner`

The following events are triggered based on the functions above:

`transfer(address indexed _from, address indexed _to, uint256 _value)`: this is triggered whenever tokens are transferred

`approval(address indexed _owner, address indexed _spender, uint256 _value)`: is triggered on any call to `approve()`

ERC-20 was proposed in 2015 and officially formalized in September 2017. It is a great starting point for token standardization. However, some in the developer community have noted that it has certain flaws and vulnerabilities.

## Whats in the ERC-223 Standard?
A post by developer `Dexaran` describes these two scenarios in detail:

There are two ways of performing a transaction in ERC20 tokens:
1. transfer function.
2. approve + transferFrom mechanism.

Token balance is just a variable in the token contract.
The transaction of a token is a change in the internal variables of the contract. The balance of the sender will be decreased and the balance of the recipient will be increased.
The transfer function will not notify the recipient when the transaction occurs. The recipient will not be able to recognize the incoming transaction! I wrote this illustration of the process that is leading to unhandled transactions and money losses.

As a result, if the recipient is a contract, users must transfer their tokens using the approve +transferFrom mechanism. If the recipient is an externally owned account address, users must transfer their tokens via the transfer function. If a user makes a mistake and chooses the wrong function, the token will get stuck inside contract (contract will not recognize a transaction). There will be no way to extract stuck tokens.

His proposed solution to this issue is contained within ERC-223. It is very similar to the ERC-20 standard, but it solves the problems described above. When tokens are transferred to a smart contract,a special function of that contract is `tokenFallback`. This allows the receiving contract to decline the tokens or trigger further actions. This can be used in place of the approve function in most cases.

## The Advantages of ERC223 : 

#### Handle incoming transactions in smart contracts
ERC223 provides a consistent way to handle incoming token transactions in smart contracts, empowering developers to create more innovative protocols.

#### Improved security
Because ERC223 makes developers handle incoming transactions explicitly it protects consumers from sending tokens to a smart contract that doesn't support them. So far, this issue has resulted in more than $400,000 in various tokens to get irredeemably lost. With ERC223 this problem is in the past.

#### Lower fees
ERC20 prescribes a pull mechanism for retrieving the funds, especially when it comes to dealing with smart contracts. This means you have to pay the gas fee twice: first time to approve the transaction, and the second time to actually receive the funds. ERC223 manages to handle transactions without going through this lovely puzzle, so you only have to pay the fee once.