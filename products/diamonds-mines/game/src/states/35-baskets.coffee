class Phacker.Game.Baskets

    constructor: (@gm) ->
        @_fle_ = 'Baskets'

        @Pm = @gm.parameters    # globals parameters
        @pm = @Pm.bsks =
            x1: @Pm.rope.x0 - @Pm.rope.w/2 + 2,         y1: @gm.parameters.rope.y0 + 2
            x2: @Pm.rope.x0 + @Pm.rope.w/2 - 2,         y2: @gm.parameters.rope.y0 + 2
            x3: @Pm.rope.x0 + @Pm.rope.w/2 - 2,         y3: @gm.parameters.rope.y0 + @Pm.rope.h - 10
            x4: @Pm.rope.x0 - @Pm.rope.w/2 + 2,         y4: @gm.parameters.rope.y0 + @Pm.rope.h - 2
            n: 6
            v:@gm.gameOptions.vx0 #baskets velocity
        #@pm.bsk_remaining = @pm.n

        @bska = []                                   # Array of baskets object

        @mk_bsk()

    #.----------.----------
    # create a basket
    #.----------.----------
    mk_bsk: ->
        @bska.push bkO = new Phacker.Game.OneBasket @gm, {x: @pm.x2, y:@pm.y2, branch:'E' }
        #console.log @_fle_,': ',@bska