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
      setTimeout(->
        alert "Player wins (Dealer busts)"
      ,600)
      @get('playerHand').playable = false
    else if dealerScore > playerScore and dealerScore < 22
      setTimeout(->
        alert "Dealer wins (closer to 21)"
      ,600)
      @get('playerHand').playable = false
    else
      setTimeout(->
        alert "Player wins (other)"
      ,600)
      @get('playerHand').playable = false


