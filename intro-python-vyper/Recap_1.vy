# pragma version 0.4.0

# 1. We create a new type called struct of Person with data
struct Person:
    fav_num: uint256
    name: String[100]

# 2. Created several state var 
list_of_num: public(uint256[5])
list_of_people: public(Person[5])
index: public(uint256) # for both list and name
name_to_fav_number: public(HashMap[String[100], uint256])

# 3. Special deploy function, init, constructor

# @deploy
# # def __init__():
    
@external
def add_person(name:String[100], fav_num: uint256):
# add fav number to number's list
    self.list_of_num[self.index] = fav_num

# add person to person's list
    new_person: Person = Person(fav_num = fav_num, name = name)
    self.list_of_people[self.index] = new_person

# add person to hashmap
    self.name_to_fav_number[name] = fav_num

    self.index = self.index + 1


# note :
# we'r not gonna deploy our contract on testnet because u always 
# be testing locally
# never rely on testnet to deploy ur smart contract until it's last step 
# before you get audited.

# note - ZkSync plugin only works with Solidity and not Vyper currently