class Phacker.Game.OneBasket

    constructor: (@gm,@lstP) -> # lstP for list oparameters of the basket
        @_fle_ = 'One bsk'
        @Pm = @gm.parameters                        # globals parameters
        @pm = @Pm.bsk =                             # one basket parameters
            # @bsk.x when basket must rotate up or down
            xrot1: @Pm.rope.x0 - 90                 # on north rope branch rotation x
            xrot2: @Pm.rope.x0 + @Pm.rope.w/6       # on the other side
            w:  42
            h:  54
            v: @Pm.bsks.v
            names: ['blue_basket','green_basket','normal_basket','pink_basket','red_basket']
            xrot1: @Pm.rope.x0 - 120                # on north rope branch down rotation x
            xrot2: @Pm.rope.x0 + @Pm.rope.w/6       # back up rotation
            vtta : 250                              # basket rotation velecity

        @vertices= [ -@pm.w/2+4,-@pm.h/2,  -@pm.w/2+10,@pm.h/2-5,  @pm.w/2-10,@pm.h/2-5,  @pm.w/2-4,-@pm.h/2 ] # body basket
        @bsk = {}                                   #  one basket prototype

        @mk_bsk(@lstP ) # lstP for list oparameters of the basket

    #.----------.----------
    # make the basket and create @bsk sprite
    #.----------.----------

    mk_bsk:(lstP)-> # make the basket; lstp={x,y,branch}
        col = @gm.rnd.integerInRange(0,4) # define color basket

        @bsk = @gm.add.sprite lstP.x,lstP.y, @pm.names[col]
        @gm.physics.box2d.enable @bsk
        @bsk.body.setChain @vertices
        @bsk.body.kinematic = true
        @bsk.body.friction = 0.01
        #@bsk.body.gravityScale = 0
        #@bsk.body.static = true

        @bsk.body.pm={}
        @bsk.body.pm.branch = lstP.branch
        @bsk.body.pm.color = col
        @bsk.body.pm.down =  false

        #@bsk.body.setBodyContactCallback(@btmO.btm, @btmCallback, @);

        if       @bsk.body.pm.branch is 'E' then @bsk.body.setZeroVelocity() ;  @bsk.body.moveDown  @pm.v
        else if  @bsk.body.pm.branch is 'S' then @bsk.body.setZeroVelocity() ;  @bsk.body.moveLeft  @pm.v
        else if  @bsk.body.pm.branch is 'W' then @bsk.body.setZeroVelocity() ;  @bsk.body.moveUp    @pm.v
        else if  @bsk.body.pm.branch is 'N' then @bsk.body.setZeroVelocity() ;  @bsk.body.moveRight @pm.v

#        tl = new Phacker.Game.Tools @gm
#        tl.show_vertices @bsk, @vertices

    #.----------.----------
    # move one basket
    #.----------.----------
    move : () ->
        if @bsk.body.pm.branch is 'N'
            if @bsk.x > @Pm.bsks.x2   # normal rot to south a the end of branch
                @bsk.body.setZeroVelocity()
                @bsk.body.moveDown @pm.v
                @bsk.body.pm.branch = 'E'

            else if @gm.math.fuzzyEqual @bsk.x, @pm.xrot1, 4 # rotate down basket
                @bsk.body.rotateRight @pm.vtta

            else if not @bsk.body.pm.down  and @gm.math.fuzzyEqual @bsk.body.angle, 165, 4 # stop rotation down
                @bsk.body.pm.down = true
                @bsk.body.rotateRight 0

            else if @gm.math.fuzzyEqual @bsk.x, @pm.xrot2, 4 # stop rotation down
                @bsk.body.rotateLeft @pm.vtta

            else if @gm.math.fuzzyEqual @bsk.body.angle, 0, 4 # rotate back up
                @bsk.body.rotateLeft 0
                @bsk.body.pm.down = false
                @bsk.body.angle = 0
                console.log @_fle_, ': ', @bsk.body.angle

        else if @bsk.body.pm.branch is 'E' and @bsk.y > @Pm.bsks.y3
            @bsk.body.setZeroVelocity()
            @bsk.body.moveLeft  @pm.v
            @bsk.body.pm.branch = 'S'

        else if @bsk.body.pm.branch is 'S' and @bsk.x < @Pm.bsks.x4
            @bsk.body.setZeroVelocity()
            @bsk.body.moveUp  @pm.v
            @bsk.body.pm.branch = 'W'

        else if @bsk.body.pm.branch is 'W' and @bsk.y < @Pm.bsks.y1
            @bsk.body.setZeroVelocity()
            @bsk.body.moveRight  @pm.v
            @bsk.body.pm.branch = 'N'

