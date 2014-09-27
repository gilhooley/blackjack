class window.AppView extends Backbone.View

  template: _.template '
    <h1>blackjack: a game</h1>
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button> <button class="new-game-button">New game</button>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>


  '

  events:
    "click .hit-button": -> @model.get('playerHand').hit()
    "click .stand-button": -> @model.get('playerHand').stand()
    "click .new-game-button": -> document.location.reload(true);

  initialize: ->
    @render()

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el
