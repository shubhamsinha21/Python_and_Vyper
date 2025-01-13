# pragma version 0.4.0 
# This is a way to declare version in vyper
# we"ll use mostly this version
# ^0.4.0 ->  greater than this
# -> used for comments both in vyper and python
# @License MIT -> means it's a open source, a legal stuff, some compiler may complain if you dont have 
# Compiling -> Remix compiler code from human readable -> machine readable (0's and 1's)

# we'r building a fav things list-
# it stores fav numbers
# fav people with their fav numbers

# types in vyper -------------------------
# has_favorite_number: bool
# my_favorite_number: uint256 
# uint -> it says this is an unsigned integer , +ve no
# int -> it has -ve or 0
# my_address: address * being in comment
# my_decimal: decimal
# my_bytes: bytes32

# Variable Visibility and deploy to remix VM -------------------
my_fav_number: public((uint256)) # 0
# this is called as state variable, storage variable
# initialized to default value
# public keyword makes var visible and readable
# if not declared public, it will considered internal

# @external # it is decorator, which means this function can be called by us
# make no sense now, so ignore


# Functions ('def' keyword ) --------------
# @internal
@external
def store(new_number: uint256):
    self.my_fav_number = new_number

# def -> for definition 
# store -> function name
# () -> for adding params and their type
# self -> is a keyword in vyper that refers to the script/contract we'r writing 
# self. -> points to the state variable , if you not add self
# it will confused whether u'r declaring a new variable or what

# Function visibility -----------------

# @internal # decalared so, if you dont have a public keyword, 
# you neither see any variale, nor store
# internal means it can only be called by other functions

# @external
# def other_store():
#     self.store(10)

# View and Pure decorator in vyper
@external
@view ## now we told compiler. we'r nt gonna spend gas on this

def retrieve() -> uint256: # external view function
# directs to retriving something of typeuint256
    return self.my_fav_number

# after deploy, remix shows buttons
# blue btn indicates that we'r nt sending transaction rather just reading states
# hence , we dont spend any gas fees
# when we call store, we have to store the data
# hence updating state and need gas fees
# In retrieve, we aren't updating, just returning..
# but also making transaction since we didnt tell vyper that this should't send transaction

# from external, we can call internal one bt nt vice versa

# a view function can be called by
# a human for free

# when a transaction (external) calls a view function
# its costs fees
