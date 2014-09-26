# At the very least you should test the scoring of hands and your model of a deck of cards.
assert = chai.assert

expect = chai.expect
  # , foo = 'bar'
  # , beverages = { tea: [ 'chai', 'matcha', 'oolong' ] };


describe "blackjack view", ->
  hand = new Hand()
  it "should have a bust method", ->
    expect(hand.bust).to.be.a('function');
  it "should have a win method", ->
    expect(hand.win).to.be.a('function');
