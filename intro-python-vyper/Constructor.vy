# pragma version 0.4.0

# Constructor, __init__, deploy ----------------------
# It is a special function that gets called only
# once when the contract is deployed
# the main use id to set some state variables
# or to call other functions that'r needed to setup contract
# Most common things to be done inside constructor 
# is to set the owner of constructor
# for example:-

owner: public(address)

# @deploy  # with this decorator starts the constructor
# def __init__(): # __init__ is special function 
# parenthesis can have some params
# setting owner state variable
# msg sender -> refers to the account that deploys this contract
# simplifies as the owner of contract = the deployer of the contract

# examples of passing params

name: public(String[100]) 
# string type , max length = 100
expiresAt: public(uint256)
my_fav_number: public(uint256)

@deploy
def __init__(name: String[100], duration: uint256):
    self.owner = msg.sender
    self.name = name
    self.expiresAt = duration + block.timestamp
    self.my_fav_number = 7


