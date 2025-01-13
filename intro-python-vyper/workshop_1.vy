# pragma version 0.4.0

struct Person:
    name: String[100]
    age: uint256

fav_num: public(uint256)

# defining state var to store a Person of type 'struct'
person: public(Person)

@deploy 
def __init__():
    self.fav_num = 8

@external
def add():
    self.fav_num = self.fav_num + 1

@external
@view
def check() -> uint256:
    return self.fav_num

@external
def save_person(_name:String[100], _age:uint256):
    new_person: Person = self.person
    new_person.name = _name
    new_person.age = _age
    self.person = new_person


# check done
# assign 7 done
# add 1 done
