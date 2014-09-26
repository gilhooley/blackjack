class window.HandView extends Backbone.View

  className: 'hand'

  #todo: switch to mustache
  template: _.template '<h2><% if(isDealer){ %>Dealer<% }else{ %>You<% } %> (<span class="score"></span>)</h2>'

  initialize: ->
    @collection.on 'add remove change', => @render()
    @render()

  acing: (scoreArray) ->
    if scoreArray.length == 1
      return scoreArray[0]

    else if Math.max(scoreArray[0], scoreArray[1]) <= 21
      return Math.max(scoreArray[0], scoreArray[1])
    else
      return Math.min(scoreArray[0], scoreArray[1])

  render: ->
    @$el.children().detach()
    @$el.html @template @collection
    @$el.append @collection.map (card) ->
      new CardView(model: card).$el
    @$('.score').text(@acing(@collection.scores()))

