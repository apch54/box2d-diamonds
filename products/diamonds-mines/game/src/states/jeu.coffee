class @YourGame extends Phacker.GameState

    update: ->
        super() #Required
        @gateO.check()
        @diamondsO.check()
        @basketsO.move() if @buttonO.pm.game_started
#
        if (msg =  @socleO.get_msg()) is 'win' then @win()
        #@game.debug.box2dWorld()
        #@game.debug.body @btm

    resetPlayer: ->
        console.log "Reset the player"

    create: ->
        super() #Required
        @_fle_ = 'create'
        @game.physics.startSystem(Phaser.Physics.BOX2D)
        #@game.physics.box2d.debugDraw.joints = true
        @game.physics.box2d.gravity.y = @game.gameOptions.gravityY

        @socleO     = new   Phacker.Game.Socle      @game
        @ropeO      = new   Phacker.Game.Rope       @game
        @bottomO    = new   Phacker.Game.Bottom     @game
        @mecanicO   = new   Phacker.Game.Mecanic    @game
        @buttonO    = new   Phacker.Game.Buttom     @game
        @gateO      = new   Phacker.Game.Gate       @game, @mecanicO
        @basketsO   = new   Phacker.Game.Baskets    @game
        @diamondsO  = new   Phacker.Game.Diamonds   @game, @bottomO
#
        @buttonO.bind @basketsO
        @basketsO.bind @diamondsO
        @basketsO.create_callback @diamondsO.dmds
#        @mecanicO.bind @diamondsO

        #@gateO.bind @mecanicO

