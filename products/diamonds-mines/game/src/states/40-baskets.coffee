class Phacker.Game.Baskets

    constructor: (@gm, @effO, @bonusO) ->
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
            n_diamonds_for_bonus: @gm.gameOptions.n_diamonds_for_bonus



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

        #test collide out
        if dmdb.y < bskb.y-22
            dmdb.x = bskb.x ; dmdb.y += 20
            dmdb.setZeroVelocity()
            dmdb.moveDown  200
        else if bskb.x-14 > dmdb.x  then return
        if bskb.x+14 < dmdb.x  then return
        if dmdb.y > bskb.y+21 then return
        if bskb.pm.branch isnt 'S' then return

        # bonus here had been recieved
        if (bskb.pm.full.length is @pm.n_diamonds_for_bonus) and (@gm.ge.score > 50) and not bskb.pm.had_bonus
            @Pm.msg.push 'bonus'            # score a bonus
            bskb.pm.had_bonus = true
            @bonusO.draw_bonus bskb         # draw bonus animation on basket

        # win part
        else
            dmdb.pm.in_bsk = true
            bskb.pm.full.push dmdb
            @effO.play bskb, 3
            @Pm.msg.push 'win'
        #console.log @_fle_,': ',bskb.pm

#    #.----------.----------
#    # check if collision is out
#    #.----------.----------
#    collide_out: (bskb, dmdb) -> # bodies of diamond and bascket
#        return true
#        if dmdb.y < bskb.y-22
#            dmdb.x = bskb.x ; dmdb.y += 20
#            return false
#        if bskb.x-14 > dmdb.x  then return true
#        else if bskb.x+14 < dmdb.x  then return true
#        if dmdb.y > bskb.y+21 then return true
#
#
#    #.----------.----------
#    # check if collision is out
#    #.----------.----------
#    collide_out: (dmd, bsk) -> # bodies of diamond and bascket

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
            b.move() if b.bsk.body?

    #.----------.----------
    # move all baskets
    #.----------.----------
    bind: (dmdO) ->
        @dmdO = dmdO
        @dmds = @dmdO.dmds
        #console.log @_fle_,': ', @dmds[0]