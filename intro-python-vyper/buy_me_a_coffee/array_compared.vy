# dynamic array Vs fixed array
dynamic_size_array: public(DynArray[uint256, 100]) # 0, 1, 2, 3
# everytime u add something to array/list, it"ll grow in size

fixed_size_array: public(uint256[100]) # length = 100 , alltimes
index: uint256

@external
@view
def dyn_array_size() -> uint256:
    return len(self.dynamic_size_array)

# @external
# @view
# def fix_array_size() -> uint256:
#     # return len(self.fixed_size_array)
#     pass

@external
def add_to_array():
    self.dynamic_size_array.append(9)
    self.fixed_size_array[self.index] = 1
    self.index += 1