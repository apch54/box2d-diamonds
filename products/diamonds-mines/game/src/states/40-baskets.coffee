class Phacker.Game.Baskets

    constructor: (@gm, @effO) ->
        @_fle_ = 'Baskets'

        @Pm = @gm.parameters    # globals parameters
        @pm = @Pm.bsks =
            x1: @Pm.rope.x0 - @Pm.rope.w/2 + 2,         y1: @gm.parameters.rope.y0 + 2
            x2: @Pm.rope.x0 + @Pm.rope.w/2 - 2,         y2: @gm.parameters.rope.y0 + 2
            x3: @Pm.rope.x0 + @Pm.rope.w/2 - 2,         y3: @gm.parameters.rope.y0 + @Pm.rope.h - 10
            x4: @Pm.rope.x0 - @Pm.rope.w/2 + 2,         y4: @gm.parameters.rope.y0 + @Pm.rope.h - 2
            n: 6
            v:@gm.gameOptions.vx0 #baskets velocity
            in:1
            dead_bsk:0
            game_over: false


        #@pm.bsk_remaining = @pm.n
        @bska = []  # Array of basket objects
        @mk_bsk()
        #@anim(0)

    #.----------.----------
    # create one basket and then callback
    #.----------.----------
    mk_bsk: ->

        for ii in [0..@pm.n-1]
            @bska.push bkO = new Phacker.Game.OneBasket @gm, {x: @pm.x2, y:@pm.y2, branch:'E',i: ii }

    #.----------.----------
    # create one basket and then callback
    # called by diamondsO when finshed in dreate phase
    #.----------.----------

    create_callback:(dmds)->
        for d in dmds #collision  with dimonds body (dmdb)
            for bkO in @bska
                bkO.bsk.body.setBodyContactCallback(d, @bskCallback, @)  # contact with botom

    #.----------.----------
    # collision callback with dimonds body (dmdb)
    #.----------.----------
    bskCallback: (bskb, dmdb, fixture1, fixture2, begin)->
        if dmdb.pm.in_bsk then return # already had scored
        dmdb.pm.in_bsk = true
        bskb.pm.full.push dmdb
        @effO.play bskb, 3
        @Pm.msg.push 'win'
        #console.log @_fle_,': ',bskb.pm

    #.----------.----------
    # start moving the basket ## for greenbutton mainly
    #.----------.----------
    anim: (n) ->
        #console.log @_fle_,': ',@bska[0]
        @bska[n].anim()

    #.----------.----------
    # move all baskets
    #.----------.----------
    move : () ->

        # first make all baskets THE FIRST is created in green_button object
        if @pm.in < @pm.n               # not enough baskets so create them
            b = @bska[@pm.in-1].bsk
            li = 2 * (@Pm.rope.w + @Pm.rope.h) / @pm.n # space tween 2 baskets

            if @gm.math.fuzzyEqual(b.y - @pm.y2, li, 4)  # create an other basket
                @anim(@pm.in) # anim a basket
                @pm.in++

        for b in @bska
            b.move()

    #.----------.----------
    # move all baskets
    #.----------.----------
    bind: (dmdO) ->
        @dmdO = dmdO
        @dmds = @dmdO.dmds
        #console.log @_fle_,': ', @dmds[0]