class @YourGame extends Phacker.GameState

    update: ->
        super() #Required
        @gateO.check()
        @diamondsO.check()
        @basketsO.move() if @buttonO.pm.game_started
#
        if (msg =  @socleO.get_msg()) is 'win'  then @win()
        else if msg is 'no dmd'                 then @lostLife()
        else if msg is 'no bsk'                 then @lostLife()
        else if msg is 'lost btm'               then @lost()
        else if msg is 'lost bsk'               then @lost()

        #@game.debug.box2dWorld()
        #@game.debug.body @btm

    resetPlayer: ->
        console.log "Reset the player"

    create: ->
        super() #Required
        @_fle_ = 'create'
        @game.physics.startSystem(Phaser.Physics.BOX2D)
        @game.physics.box2d.gravity.y = @game.gameOptions.gravityY

        @socleO     = new   Phacker.Game.Socle      @game
        @ropeO      = new   Phacker.Game.Rope       @game
        @effectO    = new   Phacker.Game.Effects    @game
        @bottomO    = new   Phacker.Game.Bottom     @game
        @mecanicO   = new   Phacker.Game.Mecanic    @game
        @buttonO    = new   Phacker.Game.Buttom     @game
        @gateO      = new   Phacker.Game.Gate       @game,  @mecanicO
        @basketsO   = new   Phacker.Game.Baskets    @game,  @effectO
        @diamondsO  = new   Phacker.Game.Diamonds   @game,  @bottomO,    @effectO
#
        @buttonO.bind @basketsO
        @basketsO.bind @diamondsO
        @basketsO.create_callback @diamondsO.dmds
#        @mecanicO.bind @diamondsO

        #@gateO.bind @mecanicO

