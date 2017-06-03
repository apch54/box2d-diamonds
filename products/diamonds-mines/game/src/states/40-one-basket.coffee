class Phacker.Game.OneBasket

    constructor: (@gm,@lstP) -> # lstP for list oparameters of the basket
        @_fle_ = 'One bsk'
        @Pm = @gm.parameters    # globals parameters
        @pm = @Pm.bsk =         # one basket parameters
            # @bsk.x when basket must rotate up or down
            xrot1: @Pm.rope.x0 - 70             # on north rope branch rotation x
            xrot2: @Pm.rope.x0 + @Pm.rope.w/6    # on the other side
            w:  42
            h:  54
            v: @Pm.bsks.v
            names: ['blue_basket','green_basket','normal_basket','pink_basket','red_basket']
        @bsk = {}

        @mk_bsk(@lstP ) # lstP for list oparameters of the basket

    #.----------.----------
    # make the basket and create @bsk sprite
    #.----------.----------

    mk_bsk:(lstP)-> # make the basket; lstp={x,y,branch}
        col = @gm.rnd.integerInRange(0,4) # define color basket
#        @bsk = @gm.add.sprite lstP.x,lstP.y, @pm.names[col] # 768x500
#        @gm.physics.arcade.enable @bsk,Phaser.Physics.ARCADE
#        @bsk.anchor.setTo(0.5, 0.5) # anchor in the middle of top

        @bsk = @gm.add.sprite lstP.x,lstP.y, @pm.names[col]
        @gm.physics.box2d.enable @bsk
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