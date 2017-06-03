class @YourGame extends Phacker.GameState

    update: ->
        super() #Required
        @gateO.check()
        @diamondsO.check()
#        @game.debug.box2dWorld()
#        @game.debug.body @btm

    resetPlayer: ->
        console.log "Reset the player"

    create: ->
        super() #Required
        @_fle_ = 'create'
        @game.physics.startSystem(Phaser.Physics.BOX2D)
        #@game.physics.box2d.debugDraw.joints = true
        @game.physics.box2d.gravity.y = 1000

        @socleO     = new   Phacker.Game.Socle      @game
        @ropeO      = new   Phacker.Game.Rope       @game
        @bottomO    = new   Phacker.Game.Bottom     @game
        @mecanicO   = new   Phacker.Game.Mecanic    @game
        @buttomO    = new   Phacker.Game.Buttom     @game
        @gateO      = new   Phacker.Game.Gate       @game, @mecanicO
        @basketsO   = new   Phacker.Game.Baskets    @game
        @diamondsO  = new   Phacker.Game.Diamonds   @game, @bottomO

        #@gateO.bind @mecanicO

