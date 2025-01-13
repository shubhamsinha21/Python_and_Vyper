# pragma version 0.4.0

@external
@view
def for_loop() -> DynArray[uint256, 10]:
    arr: DynArray[uint256, 10] = []

    for i:uint256 in range(5):
        arr.append(i)

    return arr

@external
@pure
def for_loop_start_end() -> DynArray[uint256, 10]:
    arr: DynArray[uint256, 10] = []

    for i:uint256 in range(5, 10):
        arr.append(i)

    return arr

@external
@pure
def for_loop_list() -> DynArray[uint256, 10]:
    arr: DynArray[uint256, 10] = []

    nums: uint256[4] = [11, 12, 13, 14]
    for i:uint256 in nums:
        arr.append(i)

    return arr