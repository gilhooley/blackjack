class window.CardView extends Backbone.View

  className: 'card'

  # template: _.template '<%= rankName %> of <%= suitName %>'

  initialize: ->
    @model.on 'change', => @render
    @render()

  render: ->
    @$el.children().detach().end().html
    @$el.addClass 'covered' unless @model.get 'revealed'
    if @model.get('revealed')
      @$el.css('background-image', "url(img/cards/#{@model.get('rankName')}-#{@model.get('suitName')}.png)")
    else
      @$el.css('background-image', "url(img/card-back.png)")
