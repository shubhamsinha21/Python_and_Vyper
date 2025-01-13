# Works of Smart contract
# 1. Allow us to get funds from user - so, people can buy us a coffee
# 2. withdraw that fund - so, we actually go and buy coffee
# 3. Set a min funcding value in USD

# pragma version 0.4.0
# @ license : MIT
# @ author : Shubham !

interface AggregatorV3Interface: 
    def decimals() -> uint8: view
    def description() -> String[1000]: view
    def version() -> uint256: view
    def latestAnswer() -> int256: view

minimum_usd: uint256
# making price feed variable in get_price by creating a storage variable
price_feed: AggregatorV3Interface # 0x694AA1769357215DE4FAC081bf1f309aDC325306


@deploy
def __init__(price_feed_address: address):
    self.minimum_usd = as_wei_value(5, 'ether')
    self.price_feed = AggregatorV3Interface(price_feed_address)

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
    # taking a complete function in self. | rather just a storage variable (new)
    assert usd_value_of_eth >= self.minimum_usd, "You must send more ETH" 


@external
def withdraw():
    pass

@internal 
def _get_eth_to_usd_rate(eth_amount: uint256) -> uint256:
    '''
    Chris sent 0.01 eth for us to buy coffee
    Is that more or less that $5 ?
    '''
    # actually calling the price
    price: int256 = staticcall self.price_feed.latestAnswer() # 33651000000
    # 8 decimals result - $3, 021
    # eth_to_usd

    #uint256 = int256 * (uint256)
    # vyper has convert property
    eth_price: uint256 = convert(price, uint256) * (10 ** 10) # add 10 zeros - 336510000000000000000

    # ETH
    # $ / ETH
    # $
    eth_amount_in_usd: uint256 = (eth_amount * eth_price) // (1 * (10 ** 18))
    return eth_amount_in_usd

@external
@view
def get_eth_to_usd_rate(eth_amount: uint256) -> uint256:
    return self._get_eth_to_usd_rate(eth_amount)

    
# @external 
# @view
# def get_price() -> int256:  # not wrote payable , but interacts with external contract
#     # var : type = function (address)
#     price_feed: AggregatorV3Interface = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306)
#     return staticcall price_feed.latestAnswer()

# get eth to usd will cost a gas, despite of being view ... becoz there occurs a transaction