# pragma version 0.4.0

# owner: public(address)
# owner: public(constant(address)) = msg.sender
OWNER: public(immutable(address))
# since we make it constant, need to declare value, becoz it's gonna deployed

# note - this is invalid syntax
# as the value of contract must be set when contract is compiled

VAL: public(immutable(uint256))

@deploy
def __init__(val:uint256):
    # self.owner = msg.sender 
    # since, we know that this owner is never gonna change in this contract
    # so, we'r gonna use constant because it uses less gas fee than accessing 
    # state variable
    # immutables are constants, no need to refer as self.
    OWNER = msg.sender
    VAL = val

    # all immutables var are set when contract deployed
    # immutables are set inside constructor
