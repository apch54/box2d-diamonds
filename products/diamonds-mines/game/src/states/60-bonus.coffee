###  written by apch  on 2017-05-28 ###

class Phacker.Game.Bonus

    constructor: (@gm, @bonus) ->
        @_fle_ = 'Bonus'

        @Pm = @gm.parameters

#.----------.----------
# create bonus  and destroy at the end
#.----------.----------

    draw_bonus:(obj) ->
        xx= obj.x
        #console.log @_fle_,': ',xx, obj

        style = { font: "15px Arial", fill: "#ffff00", align: "center" }
        @text = @gm.add.text xx , obj.y - 45, "Bonus", style
        @text.anchor.set 0.5
        @text.alpha= 1
        dx = -@Pm.bsks.v/7

        mvt ={
            alpha:  [0,1,0,1,0,1,0]
            angle:  [0,0,20,-20, 20,180, 360]
            x:      [xx+dx, xx+2*dx, xx+3*dx, xx+4*dx, xx+5*dx, xx+6*dx, xx+7*dx]
        }

        tw = @gm.add.tween( @text).to( mvt, 1000, "Linear", true)
        tw.onComplete.add(# on complete destoy bonus
            ()-> @text.destroy()  # destroy bonus
            @
        )

