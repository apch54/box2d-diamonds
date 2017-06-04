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

        @bska = []  # Array of basket objects

    #.----------.----------
    # create a basket
    #.----------.----------
    mk_bsk: ->
        @bska.push bkO = new Phacker.Game.OneBasket @gm, {x: @pm.x2, y:@pm.y2, branch:'E' }

        for d in @dmds #collision  with dimonds body (dmdb)
            bkO.bsk.body.setBodyContactCallback(d, @bskCallback, @)  # contact with botom

    #.----------.----------
    # collision callback with dimonds body (dmdb)
    #.----------.----------
    bskCallback: (bskb, dmdb, fixture1, fixture2, begin)->
        if dmdb.in_bsk then return # already had scored
        dmdb.in_bsk = true
        bskb.pm.full.push dmdb
        console.log @_fle_,': ',bskb.pm

    #.----------.----------
    # move all baskets
    #.----------.----------
    move : () ->

        # first make all baskets THE FIRST is created in green_button object
        if (l = @bska.length) < @pm.n               # not enough baskets so create them
            b = @bska[l-1].bsk
            li = 2*(@Pm.rope.w + @Pm.rope.h)/@pm.n    # space tween 2 baskets

            if @gm.math.fuzzyEqual(b.y - @pm.y2 ,li, 4)  # create an other basket
                @mk_bsk() # create a basket

        for b in @bska
            b.move()

    #.----------.----------
    # move all baskets
    #.----------.----------
    bind: (dmdO) ->
        @dmdO = dmdO
        @dmds = @dmdO.dmds
        #console.log @_fle_,': ', @dmds[0]