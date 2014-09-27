#todo: refactor to have a game beneath the outer blackjack model
class window.App extends Backbone.Model

  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @get('playerHand').on("checkScore", @checkScore, @)

  checkScore: ->
    @get('dealerHand').at(0).flip()
    dealerScore = @get('dealerHand').scores()[0]
    playerScore = @get('playerHand').scores()[0]
    console.log @get('playerHand').playable
    while dealerScore < 17
      @get('dealerHand').hit()
      dealerScore = @get('dealerHand').scores()[0]

    if dealerScore > 21
      alert "Player wins (Dealer busts)"
      @get('playerHand').playable = false
    else if dealerScore > playerScore and dealerScore < 22
      alert "Dealer wins (closer to 21)" + @get('dealerHand').scores()
      @get('playerHand').playable = false

    else
      alert "Player wins (other)"
      @get('playerHand').playable = false


