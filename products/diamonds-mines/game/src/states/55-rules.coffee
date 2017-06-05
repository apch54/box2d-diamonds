###  written by apch on 2017-06-05 ###

class Phacker.Game.Rules

    constructor: (@gm, @bsksO) ->
        @_fle_ = 'Rules'

        @Pm = @gm.parameters        # globals parameters
        @pm = @Pm.rls =
            #vx:     @bsksO.bska     # initial basket velocity
            dvx:    25               # variation of vx0
            #scr:    @gm.ge.score
            lvl:    0                # level inside one game
            v  :    @Pm.bsks.v       # from gameOptions


    #.----------.----------
    # checks rules an score to accelerate
    #.----------.----------
    check: ->

        switch @pm.lvl
            when 0
                if @gm.ge.score < 90 then return
                else
                    @speedup(@bsksO.pm.v + @pm.dvx)
                    @pm.lvl = 1

            when 1
                if @gm.ge.score < 180 then return
                else
                    @speedup(@bsksO.pm.v + @pm.dvx )
                    @pm.lvl = 2

    #.----------.----------
    # acceleration depending on score
    #.----------.----------
    speedup: (v0)  ->
        for b in @bsksO.bska
            bdy = b.bsk.body
            branch =bdy.pm.branch
            @bsksO.pm.v = v0
            b.pm.v = v0
            console.log @_fle_,': ',@bsksO.pm.v, b.pm.v
            #bdy.setZeroVelocity()

            switch branch
                when 'N' then bdy.moveRight v0
                when 'E' then bdy.moveDown  v0
                when 'S' then bdy.moveLeft  v0
                when 'W' then bdy.moveUp    v0
                else
                    bdy.moveDown 200
                    bdy.moveLeft 100

