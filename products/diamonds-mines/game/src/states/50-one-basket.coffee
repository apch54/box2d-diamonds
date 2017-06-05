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
            yout:  @Pm.bsks.y3-75                   # for bascket in w branche and empty ; so return home
            vtta : 250                              # basket rotation velocity


        @vertices= [ -@pm.w/2+6,-@pm.h/2,  -@pm.w/2+12,@pm.h/2-5,  @pm.w/2-12,@pm.h/2-5,  @pm.w/2-6,-@pm.h/2 ] # body basket
        @bsk = {}                                   #  one basket prototype

        @mk_bsk(@lstP ) # lstP for list oparameters of the basket

    #.----------.----------
    # make the basket and create @bsk sprite
    #.----------.----------

    mk_bsk:(lstP)-> # make the basket; lstp={x,y,branch}
        col = @gm.rnd.integerInRange(0,4) # define color basket

        @bsk = @gm.add.sprite lstP.x,lstP.y, @pm.names[col]
        @bsk.alpha = 0
        @gm.physics.box2d.enable @bsk
        @bsk.body.setChain @vertices
        @bsk.body.kinematic = true
        @bsk.body.friction = 0.01
        #@bsk.body.gravityScale = 0
        #@bsk.body.static = true

        @bsk.body.pm={}
        @bsk.body.pm.branch = lstP.branch
        @bsk.body.pm.i = lstP.i # id of basket
        @bsk.body.pm.color = col
        @bsk.body.pm.down =  false
        @bsk.body.pm.full =  []

        #@bsk.body.setBodyContactCallback(@btmO.btm, @btmCallback, @);

    #.----------.----------
    # start the baskets
    #.----------.----------

    anim:(bsk)->
        @bsk.alpha = 1
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
        # Game over ?
        console.log @_fle_,': ',@Pm.bsks.dead_bsk,@Pm.bsks.n,@Pm.bsks.game_over
        if (@Pm.bsks.dead_bsk is @Pm.bsks.n) and not @Pm.bsks.game_over
            @Pm.bsks.game_over = true
            @Pm.msg.push 'no bsk' # no more diamonds

        bskb = @bsk.body

        #.----------.----------. North branch  .----------.----------

        if bskb.pm.branch is 'N'
            if @bsk.x > @Pm.bsks.x2   # normal rot to south a the end of branch
                bskb.setZeroVelocity()
                bskb.moveDown @pm.v
                bskb.pm.branch = 'E'

            else if @gm.math.fuzzyEqual @bsk.x, @pm.xrot1, 4 # rotate down basket
                bskb.rotateRight @pm.vtta

            else if not bskb.pm.down  and @gm.math.fuzzyEqual bskb.angle, 165, 4 # stop rotation down
                bskb.pm.down = true
                bskb.rotateRight 0

            else if @gm.math.fuzzyEqual @bsk.x, @pm.xrot2, 4 # stop rotation down
                bskb.rotateLeft @pm.vtta
                # free baskets of diamonds
                for dmdb in bskb.pm.full
                    dmdb.pm.in_bsk = false #diamond can replay
                bskb.pm.full = [] # empty basket array full

            else if @gm.math.fuzzyEqual bskb.angle, 0, 4 # rotate back up
                bskb.rotateLeft 0
                bskb.pm.down = false
                bskb.angle = 0

        #.----------.----------.  East branch .----------.----------

        else if bskb.pm.branch is 'E' and @bsk.y > @Pm.bsks.y3
            bskb.setZeroVelocity()
            bskb.moveLeft  @pm.v
            bskb.pm.branch = 'S'

        #.----------.----------. South branch .----------.----------

        else if bskb.pm.branch is 'S' and @bsk.x < @Pm.bsks.x4
            bskb.setZeroVelocity()
            bskb.moveUp  @pm.v
            bskb.pm.branch = 'W'

        #.----------.----------.  West branch .----------.----------

        else if bskb.pm.branch is 'W'
            if @gm.math.fuzzyEqual @bsk.y, @pm.yout
                if bskb.pm.full.length is 0
                    bskb.setZeroVelocity()
                    bskb.moveLeft  @pm.v
                    bskb.moveDown  @pm.v*2
                    bskb.rotateLeft @pm.vtta
                    @bsk.body.pm.branch = 'X'        # no branch
                    @Pm.bsks.dead_bsk++
                    #@gm.time.events.add Phaser.Timer.SECOND * 1, @throw_bsk, @

            if @bsk.y < @Pm.bsks.y1
                bskb.setZeroVelocity()
                bskb.moveRight  @pm.v
                bskb.pm.branch = 'N'

        #.----------.----------.  Out branch .----------.----------

        if  @bsk.body.pm.branch is 'X' and @bsk.y > @Pm.bsks.y3 + 150 # lost bsk
            @bsk.body.setZeroVelocity()
            @bsk.body.x = 100
            @bsk.body.y = -100
            bskb.rotateRight 0

