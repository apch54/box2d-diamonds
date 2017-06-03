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

        #@mk_bsk()

    #.----------.----------
    # create a basket
    #.----------.----------
    mk_bsk: ->
        @bska.push bkO = new Phacker.Game.OneBasket @gm, {x: @pm.x2, y:@pm.y2, branch:'E' }
    #.----------.----------
    # move all baskets
    #.----------.----------
    move : () ->

        # first make all baskets THE FIRST is created in green_button object
        if (l = @bska.length) < @pm.n               # not enough baskets so create them
            b = @bska[l-1].bsk
            li = 2*(@Pm.rope.w + @Pm.rope.h)/@pm.n    # space tween 2 baskets

            if @gm.math.fuzzyEqual(b.y - @pm.y2 ,li, 4)  # an other basket
                @mk_bsk() # create a basket
        #console.log @_fle_,': ',@bska
        for b in @bska
            b.move()