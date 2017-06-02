###  written by apch on 2017-05-06
       ... --- ...
      |          ,---------------------------------.
      |.===.     | an other one : Diamonds mines   |
      {}o o{}    _)--------------------------------'
   ooO--(_)--Ooo-

###

class Phacker.Game.Bottom

    constructor: (@gm) ->
        @_fle_ = 'Bottom'

        @Pm = @gm.parameters
        @pm = @Pm.btm = # bottom platform
            x0: @Pm.bg.w2
            w : 375
            h : 27
        @pm.y0 = @Pm.bg.h - @pm.h
        @pm.w2 = @pm.w/2
        @pm.h2 = @pm.h/2

        @vertices = [ # define body of bottom 3 points
            -@pm.w2, 0
            0,      -@pm.h2
            @pm.w2, 0
        ]


        @btm = @draw_btm()
#        tl = new Phacker.Game.Tools @gm
#        tl.show_vertices @btm, @vertices
    #.----------.----------
    # build socle
    #.----------.----------

    draw_btm: ->

        # bottom
        btm = @gm.add.sprite @pm.x0, @pm.y0, 'platform' # 375x27
        @gm.physics.box2d.enable btm
        btm.body.static = true
        btm.body.fixedRotation = true

        btm.body.setChain @vertices

        return  btm


