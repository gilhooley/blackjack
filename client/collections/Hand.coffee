class window.Hand extends Backbone.Collection

  model: Card

  initialize: (array, @deck, @isDealer) ->

  hit: ->
    test = (scores) ->
      for total in scores
        if total < 21
         return true

    if @scores().length < 2 and @scores()[0] < 21
      @add(@deck.pop()).last()

    else if @scores().length >= 2
     console.log @scores().length


     if test(@scores())
       @add(@deck.pop()).last()

    else
      #trigger bust


  bust: ->
    # if scores() > 21, trigger bust event

  win: ->
    # scores() == 21, trigger win event
    # else if player has stopped hitting
    # & dealer scores() >= 17
    #  scores()
    #  if my score is 21 i win if im a player
    #  if my score < 21 check if my score is greater than other score

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
