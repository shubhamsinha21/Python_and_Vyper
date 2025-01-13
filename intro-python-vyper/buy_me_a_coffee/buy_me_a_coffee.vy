# pragma version 0.4.0
'''
@license MIT
@title Buy Me A Coffee!
@author You!
@notice This contract is for creating a sample funding contract

'''

interface AggregatorV3Interface: 
    def decimals() -> uint8: view
    def description() -> String[1000]: view
    def version() -> uint256: view
    def latestAnswer() -> int256: view

# storage variables

# minimum_usd: public(uint256)
# since we set once the min usd and never changes, lets make it constant

MINIMUM_USD: public(constant(uint256)) = as_wei_value(5, 'ether')
PRICE_FEED: public(immutable(AggregatorV3Interface))  # 0x694AA1769357215DE4FAC081bf1f309aDC325306
OWNER: public(immutable(address))

# how much they sent us
funders: public(DynArray[address, 1000]) # dynamic array

# tracking who send how much funded
funder_to_amount_funded: public(HashMap[address, uint256])


@deploy
def __init__(price_feed_address: address):
    '''
    self.minimum_usd = as_wei_value(5, 'ether') 
    since min usd is  const , we dont set it here
    '''

    PRICE_FEED = AggregatorV3Interface(price_feed_address) 
    OWNER = msg.sender

@external
@payable # tells that this function can work with msg.value/value
def fund():
    '''
    Allow users to send $ to this contract

    Have a min $ amount to send

    How do we send ETH to this contract ?
    '''
    # assert msg.value >= as_wei_value(1, "ether"), "You must send more ETH" 
    usd_value_of_eth: uint256 = self._get_eth_to_usd_rate(msg.value)
    # assert usd_value_of_eth >= self.minimum_usd, "You must send more ETH" 

    assert usd_value_of_eth >= MINIMUM_USD, "You must send more ETH"
    self.funders.append(msg.sender)
    self.funder_to_amount_funded[msg.sender] += msg.value

@external
def withdraw():
    '''
    Take the money out of contract, which people sent via fund function

    How do we make sure only we can pull the money out ?
    '''
    assert msg.sender == OWNER, "Not the Contract Owner !"
    # send(OWNER, self.balance) - using advanced way to send money
    raw_call(OWNER, b"" ,value = self.balance) # b stand for data we'r sending
    # resetting the hasmap
    for funder: address in self.funders:
        self.funder_to_amount_funded[funder] = 0

    self.funders = []
    

@internal 
@view
def _get_eth_to_usd_rate(eth_amount: uint256) -> uint256:
    '''
    Chris sent 0.01 eth for us to buy coffee
    Is that more or less that $5 ?
    '''

    price: int256 = staticcall PRICE_FEED.latestAnswer() # 33651000000
    eth_price: uint256 = (convert(price, uint256)) * (10 ** 10) # add 10 zeros - 336510000000000000000
    eth_amount_in_usd: uint256 = (eth_amount * eth_price) // (1 * (10 ** 18))
    return eth_amount_in_usd

@external
@view
def get_eth_to_usd_rate(eth_amount: uint256) -> uint256:
    return self._get_eth_to_usd_rate(eth_amount)


# making price feed and min usd as constant
# bt price feed can be different on different chains but once assigned, 
# will aslways same in contract
  

    # CALL DATA  - LOW LEVEL INTERACTION IN REMIX DEPLOY SECTION

@external
@payable
def __default__():
    pass
