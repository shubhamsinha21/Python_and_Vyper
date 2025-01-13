# pragma version 0.4.0

# Pure and View -> 
# it does not write anything on blockchain

# @pure - do not read any state and global variables
# @view - read state and gloabal variables
# block.timestamp - is a global variable


count: public(uint256)

@external
@pure
def add(x:uint256, y:uint256) -> uint256:
    return x + y
    # return x+y + self.count # since its reading state variable , no longer @pure

@external
@view
def add_to_count(x:uint256) -> uint256:
    return x + self.count + block.timestamp # still read only, as we'r nt making updates
    # bt not pure function since, it's reading value from state variable

@external
@view
def if_else(x:uint256) -> String[100]:
    if x > 10:
        return 'true'
        
    else:
        return 'false'
