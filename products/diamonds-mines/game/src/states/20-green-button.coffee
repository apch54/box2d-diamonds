###  written by apch  on 2017-05-31 ###

class Phacker.Game.Buttom

    constructor: (@gm) ->
        @_fle_ = 'Button'

        @pm = @gm.parameters.btn =
            x:  @gm.parameters.mec.x0 - 35
            y:  @gm.parameters.mec.y0 + 180
            w:  72
            h:  72
            game_started: false # for game starting

        @draw_button()

    #.----------.----------
    # draw button and define events
    #.----------.----------
    draw_button:()->
        @btn = @gm.add.button @pm.x, @pm.y, 'start_btn', @on_tap, @, 1, 1, 0

    #.----------.----------
    # on tap game gegins
    #.----------.----------
    on_tap: () ->
        @bsksO.anim(0) # first creation of baskets
        @btn.y = 800   # very low down
        @btn.alpha = 0

        #@dmdO.start_game()
        @pm.game_started = on
        #console.log @_fle_,': ',@pm.game_started

    #.----------.----------
    # bind witn others objects
    #.----------.----------
    bind: (bsks) -> @bsksO = bsks
