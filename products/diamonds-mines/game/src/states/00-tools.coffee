class Phacker.Game.Tools

    constructor: (@gm) ->
        @_fle_ = 'Tools'

    #.----------.----------
    #show array of vertices
    #.----------.----------

    show_vertices:(obj, ary)->
        if (l = ary.length) < 2 then return

        ii=0
        while ii < l/2
            @mk_rect obj.x + ary[2*ii], obj.y + ary[2*ii+1]
            ii++

    #.----------.----------
    #make a rectangle for bsk_body
    #.----------.----------
    mk_rect: (x,y) ->
        # create the bit map data obj : b
        b = @gm.add.bitmapData 3, 3

        # draw it
        b.ctx.beginPath()
        b.ctx.rect 0,0,  10, 10
        b.ctx.fillStyle = '#00ff00'
        b.ctx.fill()

        #add sprite in game
        s =  @gm.add.sprite  x, y, b
        s.anchor.setTo .5, .5

        return s




