# pragma version 0.4.0

# we also explored about functions

@external
@pure # another keyword
def multiply(x: uint256, y:uint256) -> uint256:
    return x * y

@external
@pure # another keyword
def divide(x: uint256, y:uint256) -> uint256:
    return x // y

# if u want to declare a function bt not want return
# or implement code yet
@external
def todo():
    pass

# returning multiple outputs 
@external
@pure
def return_many() -> (uint256, bool):
    return (123, True)

# ref types ----------------
# how to setup different things (variables)
# in single variable
# and this can be solved using Arrays and Structs
# and different reference types

# Array lists --------------------------------------
list_of_numbers: public(uint256[5])
list_of_people: public(Person[5]) 
index: public(uint256)
     
@external
def add_numbers(favorite_number : uint256):
    self.list_of_numbers[self.index] = favorite_number
    self.index = self.index + 1

# list of numbers: 7, 0, 0, 0, 0
# index:1


# Structs & Strings -------------------------------
# Now, we've to assign these numbers to different people
# Till now, we have fav list of other numbers
# hence, we've tp store those people names

struct Person:
    favorite_number: uint256
    name: String[100]

my_name: public(String[100]) # just for testing purpose

@deploy
def __init__():
    self.my_name = " Patrick !"

@external
def add_person(name:String[100], favorite_number: uint256):
    # add fav numbers to numbers list
    self.list_of_numbers[self.index] = favorite_number

    # add person to the person's list

    new_person : Person = Person(favorite_number = favorite_number, name = name)
    # (7, mark)
    self.list_of_people[self.index] = new_person

    # add person to hashmap
    self.name_to_fav_number[name] = favorite_number
    self.index = self.index + 1


# mappings (HashMap) --------------------------------------
name_to_fav_number: public(HashMap[String[100], uint256])

# hashmap -> dictionary (key- value)
# String, String
# 2 most imp data structure in smart contract programming
# hashmap & array lists & mapping
