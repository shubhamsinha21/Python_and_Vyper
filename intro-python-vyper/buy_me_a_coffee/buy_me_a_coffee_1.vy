# Works of Smart contract
# 1. Allow us to get funds from user - so, people can buy us a coffee
# 2. withdraw that fund - so, we actually go and buy coffee
# 3. Set a min funcding value in USD

# pragma version 0.4.0
# @ license : MIT
# @ author : Shubham !

interface AggregatorV3Interface: #another new type we learnt
    def decimals() -> uint8: view
    def description() -> String[1000]: view
    def version() -> uint256: view
    def latestAnswer() -> int256: view

minimum_usd: uint256

@deploy
def __init__():
    self.minimum_usd = 5

@external
@payable # tells that this function can work with msg.value/value
def fund():
    '''
    Allow users to send $ to this contract

    Have a min $ amount to send

    How do we send ETH to this contract ?
    '''

    assert msg.value >= as_wei_value(1, "ether"), "You must send more ETH" 
    # assert msg.value >= self.minimum_usd , "You must send more ETH" 
    # 3,253,11000000 - 8 decimal places

@external
# def withdraw(number: uint256) -> bool :
    # return True  
def withdraw():
    pass

@internal # internally used
def _get_eth_to_usd_rate(): # underscore -annotation for internal function

    # to reach out and interact with external contract, u need -
    # Address: 0x694AA1769357215DE4FAC081bf1f309aDC325306
    #ABI (application binary interface): 
    pass

# function for getting price 
# imp -when u call a contract outside of a current contract - need to use keyowrd
# this is only in vyper & nt solidity
# calling external contract is kinda security issue
# view function - hence staticcall keyword (no state change)
# extcall - for external call not used in view
@external 
@view
def get_price() -> int256:  # not wrote payable , but interacts with external contract
    # var : type = function (address)
    price_feed: AggregatorV3Interface = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306)
    return staticcall price_feed.latestAnswer()