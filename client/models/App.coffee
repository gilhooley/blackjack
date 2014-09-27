#todo: refactor to have a game beneath the outer blackjack model
class window.App extends Backbone.Model

  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    console.log @get('dealerHand').scores()
    @get('playerHand').on("checkScore", @checkScore, @)

  checkScore: (arg) ->
    console.log arg
    dealerScore = @get('dealerHand').scores()[0]
    playerScore = @get('playerHand').scores()[0]
    if dealerScore > playerScore
      console.log "Dealer wins"
    else
      console.log "Player wins"
