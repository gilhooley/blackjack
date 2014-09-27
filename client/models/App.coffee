#todo: refactor to have a game beneath the outer blackjack model
class window.App extends Backbone.Model

  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    console.log @get('dealerHand').scores()
    @get('playerHand').on("checkScore", @checkScore, @)

  checkScore: ->
    @get('dealerHand').at(0).flip()
    dealerScore = @get('dealerHand').scores()[0]
    playerScore = @get('playerHand').scores()[0]

    while dealerScore < 17
      @get('dealerHand').hit()
      dealerScore = @get('dealerHand').scores()[0]


    if dealerScore > playerScore
      console.log "Dealer wins"
    else
      console.log "Player wins"
