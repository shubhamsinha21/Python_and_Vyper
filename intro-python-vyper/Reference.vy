# pragma version 0.4.0

# Referenc data types
# data types passed by their reference
# for this, data are not copied
# instead, a pointer to where the data actually is stored is passed around

# ref types in vyper are 

# 1. Fixed sized lists
nums: public(uint256[10]) 
# way to define fixed size list
# in brackets -> size of list
# way to read & write in fixed size list
#----------------------------------------

# 2. Dynamic arrays
#----------------------------------------

# 3. Mapping 
# is data type built using two other value types
# 1st one will represent the key of mapping
# 2nd says value of mapping

myMapping: public(HashMap[address, uint256])
#------------------------------------------

# 4. Structs
struct Person: # it has 2 data
    name: String[10]
    age: uint256

person: public(Person) # creating state var of type - struct


@deploy
def __init__():
    self.nums[0] =  123 # we want to get the value at index 0
    self.nums[1] = 456
    self.myMapping[msg.sender] = 1
    self.myMapping[msg.sender] = 11
    # for different addresses
    self.person.name = "Byper"
    self.person.age = 33

# Loading the state var "person" into memory

    # copying the data of name and age from state variable into memory into "p"
    # this is not a stay variable
    # rather data in memory
    p: Person = self.person 
    p.name = "Solidity"
    p.age = 22
    # declaring type of p i.e; Person (struct)

