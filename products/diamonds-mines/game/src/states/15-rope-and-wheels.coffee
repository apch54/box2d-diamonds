
class Phacker.Game.Rope

    constructor: (@gm) ->
        @_fle_ = 'Rope'
        @Pm = @gm.parameters

        # for the rope
        @pm = @Pm.rope = # background
            x0: @Pm.bg.w2
            w : 329
            h : 375
            r : 20 # rope radius at the four wheels
        @pm.y0 =  if @gm.gameOptions.fullscreen  then @Pm.bg.y0 + 50 else @Pm.bg.y0 + 15
        @pm.w2 = @pm.w/2 # middle of background

        # for the wheel
        @pmw =@Pm.whl=
            x1: @pm.x0 - @pm.w2  + @pm.r
            y1: @pm.y0 + @pm .r
            x2: @pm.x0 + @pm.w2  - @pm.r
        @pmw.y2 = @pmw.y1
        @pmw.x3 = @pmw.x2
        @pmw.y3 = @pm.y0 + @pm.h - @pm.r
        @pmw.x4 = @pmw.x1
        @pmw.y4 = @pmw.y3

        @draw()

#.----------.----------
# build socle
#.----------.----------

    draw : ->
        @rop = @gm.add.sprite @pm.x0, @pm.y0, 'rope' # 329x375
        @rop.anchor.setTo(0.5, 0) # anchor in the middle of top

        # wheels
        @whl1 = @gm.add.sprite @pmw.x1, @pmw.y1, 'wheel' # 283x150
        @whl1.anchor.setTo(0.5, 0.5) # anchor in the middle of top
        @mk_tween @whl1, {  angle: 360  }, 1700

        @whl2 = @gm.add.sprite @pmw.x2, @pmw.y2, 'wheel' # 283x150
        @whl2.anchor.setTo(0.5, 0.5) # anchor in the middle of top
        @mk_tween @whl2, {  angle: 360  }, 1800

        @whl3 = @gm.add.sprite @pmw.x3, @pmw.y3, 'wheel' # 283x150
        @whl3.anchor.setTo(0.5, 0.5) # anchor in the middle of top
        @mk_tween @whl3, {  angle: 360  }, 1900

        @whl4 = @gm.add.sprite @pmw.x4, @pmw.y4, 'wheel' # 283x150
        @whl4.anchor.setTo(0.5, 0.5) # anchor in the middle of top
        @mk_tween @whl4, {  angle: 360  }, 2000

    #__________.__________
    # make twen for object with lst variation paramaters an during t
    # __________.__________

    mk_tween:(spt, lst , t) -> #for wheel
        tw = @gm.add.tween spt
        tw.to( lst, t, Phaser.Easing.Linear.None, true, 0, -1 )