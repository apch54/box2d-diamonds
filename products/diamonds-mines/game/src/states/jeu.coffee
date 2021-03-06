class @YourGame extends Phacker.GameState

    update: ->
        super() #Required
        @gateO.check()
        @diamondsO.check()
        @basketsO.move() if @buttonO.pm.game_started
#
        msg =  @socleO.get_msg()
        switch msg
            when 'win'               then @win()
            when 'lost bsk'          then @lostLife()
            when 'lost btm'          then @lost()
            when 'bonus'             then @winBonus()
            when 'no dmd', 'no bsk'  then @endGame()


        @rulesO.check()

        #@game.debug.box2dWorld()
        #@game.debug.body @btm

    resetPlayer: ->
        console.log "Reset the player"

    create: ->
        super() #Required
        @_fle_ = 'create'

        # ---------- hack ----------
        @scoreText.setText(@game.ge.score)
        @scoreText.y = @statusBar.height*0.5 - @scoreText.height*0.5

        @levelText.setText(@game.ge.level)
        @levelText.y = @statusBar.height*0.5 - @levelText.height*0.5
        #---------------------------

        @game.physics.startSystem(Phaser.Physics.BOX2D)
        @game.physics.box2d.gravity.y = @game.gameOptions.gravityY

        @socleO     = new   Phacker.Game.Socle      @game
        @ropeO      = new   Phacker.Game.Rope       @game
        @effectO    = new   Phacker.Game.Effects    @game
        @bottomO    = new   Phacker.Game.Bottom     @game
        @mecanicO   = new   Phacker.Game.Mecanic    @game
        @buttonO    = new   Phacker.Game.Buttom     @game
        @gateO      = new   Phacker.Game.Gate       @game,   @mecanicO
        @bonusO     = new   Phacker.Game.Bonus      @game
        @basketsO   = new   Phacker.Game.Baskets    @game,   @effectO,    @bonusO
        @diamondsO  = new   Phacker.Game.Diamonds   @game,   @bottomO,    @effectO
        @rulesO     = new   Phacker.Game.Rules      @game,   @basketsO

        @buttonO.bind @basketsO
        @basketsO.bind @diamondsO
        @basketsO.create_callback @diamondsO.dmds # 700 callbacks created
#        @mecanicO.bind @diamondsO

        #@gateO.bind @mecanicO

