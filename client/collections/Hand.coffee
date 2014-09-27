class window.Hand extends Backbone.Collection

  model: Card
  playable: true;

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
    if @playable
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

    if @scores()[0] == 21
      @win()
    else if @scores()[0] > 21
      @bust()

  stand: ->
    if @playable
      if @scores().length < 2
        if @scores()[0] == 21
          @win()
        else if @scores()[0] > 21
          @bust()
        else if @scores()[0] < 21
          @trigger("checkScore")
      else
        @trigger("checkScore")

  bust: ->
    setTimeout(->
      alert "Player loses (bust)"
    ,600)
    @playable = false;

  win: ->
    setTimeout(->
      alert "Player wins"
    ,600)
    @playable = false;

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

