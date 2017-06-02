class Phacker.Game.Mecanic

    constructor: (@gm) ->
        @_fle_ = 'Socle'
        @Pm = @gm.parameters

        @pm = @Pm.mec = # mechanic
            x0: @Pm.bg.w2
            y0: @Pm.bg.y0 + 105
            w : 283
            h : 150
        @pm.x1= @pm.x0 - @pm.w/2 + 2;       @pm.y1= @pm.y0 + 88     #hight-left
        @pm.x2= @pm.x0 - 13;                @pm.y2= @pm.y1 + 32     #middle l
        @pm.x3= @pm.x2;                     @pm.y3= @pm.y2 + 30
        @pm.x3= @pm.x2;                     @pm.y3= @pm.y2 + 30
        @pm.x4= 2*@pm.x0 - @pm.x3 + 2;      @pm.y4= @pm.y3          #low right
        @pm.x5=  @pm.x4;                    @pm.y5= @pm.y2
        @pm.x6= 2*@pm.x0 - @pm.x1 - 1;      @pm.y6= @pm.y1

        @draw()
        @mk_bodies()

    #.----------.----------
    #draw mecanic
    #.----------.----------
    draw:  ->
        @mec = @gm.add.sprite @pm.x0, @pm.y0, 'mecanic' # 283x150
        @mec.anchor.setTo(0.5, 0) # anchor in the middle of top

    mk_bodies: ->
        # left
        @pm.left_vtx = [
            @pm.x1,         @pm.y1-20
            @pm.x1,         @pm.y1
            @pm.x2,         @pm.y2
            @pm.x3,         @pm.y3
        ]
        @left_body = new Phaser.Physics.Box2D.Body @gm, null, 0, 0, 0
        @left_body.setChain  @pm.left_vtx

#        tl = new Phacker.Game.Tools @gm
#        tl.show_vertices @left_body, @pm.left_vtx

        # right
        @pm.right_vtx = [
            @pm.x6,         @pm.y6-20
            @pm.x6,         @pm.y6
            @pm.x5,         @pm.y5
            @pm.x4,         @pm.y4
        ]
        @right_body = new Phaser.Physics.Box2D.Body @gm, null, 0, 0, 0
        @right_body.setChain  @pm.right_vtx

        #tl = new Phacker.Game.Tools @gm
        #tl.show_vertices @right_body, @pm.right_vtx