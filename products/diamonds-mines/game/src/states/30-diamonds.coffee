class Phacker.Game.Diamonds

    constructor: (@gm, @btmO) ->
        @_fle_ = 'Diamonds'

        @Pm = @gm.parameters    # globals parameters
        @pm = @Pm.dmds = # as diamonds
            w: 10
            h:10
            n_in: 0         # number of diamond in game
            max_in :15      # max of diamond in game"
            last_used:-1    # last in game (dmd)
            n: 97 # number of diamonds
            dmd_in_game: 15
            names: ['blue_ball', 'green_ball', 'pink_ball', 'red_ball', 'yellow_ball']
            x1: @Pm.mec.x0 - @Pm.mec.w/2 + 9   #left position
            x2: @Pm.mec.x0 - 18                # middle location
            x3: @Pm.mec.x0 + @Pm.mec.w/2 - 49   # right location
            y1: @Pm.mec.y0 + 68
            msg_n: 'ok'

        @dmds = []
        @mk_all_dmd()

    #.----------.----------
    # check diamond in game
    #.----------.----------
    check: () ->
        if not @Pm.btn.game_started  then return
        if @pm.n_in < @pm.max_in and @pm.last_used < @pm.n
            @pm.last_used++
            @dmds[@pm.last_used].body.static = false
            @pm.n_in++

    #.----------.----------
    # creation of all diamonds (ball)
    #.----------.----------
    mk_all_dmd : () ->
        col1=@gm.rnd.integerInRange(0,4) # define colors
        col2=(col1+1)%5
        col3=(col1+2)%5

        for i in [0..@pm.n]

            if i < 28
                col = col1
                if (i % 4) is 0 then x = @pm.x2 ; y = @pm.y1 - Math.floor(i/4) *10
                else x += 10

            else if i < 63
                col = col2
                if (i-28) % 5 is 0 then x = @pm.x1 ; y = @pm.y1 - Math.floor((i-28)/5) *10
                else x += 10

            else if i < 98
                col = col3
                if (i-63) % 5 is 0 then x = @pm.x3 ; y = @pm.y1 - Math.floor((i-63)/5) *10
                else x += 10

            dmd = @mk_dmd x, y, @pm.names[col]
            @dmds.push dmd

    #.----------.----------
    # make a diamond
    #.----------.----------

    mk_dmd:(x, y, frame)->
        spt = @gm.add.sprite x, y, frame
        @gm.physics.box2d.enable spt
        spt.body.setCircle spt.width / 2
        spt.body.friction = 0.01
        #spt.body.gravityScale = 0
        spt.body.static = true

        spt.body.pm={}
        spt.body.pm.n = @dmds.length # 0 for the first
        spt.body.pm.dead = false
        spt.body.friction = 0.01
        spt.body.setBodyContactCallback(@btmO.btm, @btmCallback, @);

        return spt

    #.----------.----------
    # collision call back with bottom sprite
    #.----------.----------
    btmCallback: (dmdb, btmb, fixture1, fixture2, begin) -> # diamond body, bottom.body
        if dmdb.pm.dead then return
        dmdb.pm.dead = true
        @pm.n_in--

        #console.log @_fle_,': ',dmdb

