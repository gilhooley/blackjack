class window.Hand extends Backbone.Collection

  model: Card

  currentPlayer: (@isDealer) ->
    if @isDealer then currPlayer = "Dealer"
    else currPlayer = "You"
    return currPlayer

  initialize: (array, @deck, @isDealer) ->
    @on('hit', @hit, @)
    @on('stand', @stand, @)
    @on('bust', @bust, @)
    @on('win', @win, @)
    @currentPlayer(@isDealer)

  hit: ->

    test = (scores) ->
      for total in scores
        if total < 21
         return true

    if @scores().length < 2 and @scores()[0] < 21
      @add(@deck.pop()).last()

    else if @scores().length >= 2
     if test(@scores())
       @add(@deck.pop()).last()
     else
      @bust()

    else
      @bust()
     # if scores() > 21, trigger bust event

  stand: ->
    # scores() == 21, trigger win event
    # & dealer scores() >= 17
    #  scores()
    #  if my score is 21 i win if im a player
    #  if my score < 21 check if my score is greater than other score

  bust: ->
    # tell player a loss happened
    #console.log "#{@currentPlayer()} bast!"
    # other = @isDealer or "You"
    #trigger other other player wins
    alert "#{@currentPlayer()} busted"

  win: ->
    # tell player he's won
    alert "You won!"

  scores: ->
    # The scores are an array of potential scores.
    # Usually, that array contains one element. That is the only score.
    # when there is an ace, it offers you two scores - the original score, and score + 10.
    hasAce = @reduce (memo, card) ->
      memo or card.get('value') is 1
    , false
    score = @reduce (score, card) ->
      score + if card.get 'revealed' then card.get 'value' else 0
    , 0
    if hasAce then [score, score + 10] else [score]
