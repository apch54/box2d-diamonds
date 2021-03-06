class Phacker.Game.Effects

    constructor:(@gm) ->
        @_fle_      ='Effect'
        @effects = ['effect1','effect3','effect4','effect5']
        @last_eff_time = 0
        @delay= 250

    #.----------.----------
    # effect  with no color effect
    # .----------.----------

    play:(obj,n) ->
        nowt = new Date().getTime()
        if not n? then n = @gm.rnd.integerInRange 0, 2 # choose animation

        if not (n is 3) and (nowt - @last_eff_time < @delay) then return
        else if n isnt 3 then  @last_eff_time =nowt


        switch n
            when 0,1
                eff= @gm.add.sprite 50, 100, @effects[n] ,2 #86x88 & create effect
                anim = eff.animations.add  'explode', [2, 1, 0, 1], 8, false
            when 2
                eff= @gm.add.sprite 50, 100, @effects[n] ,4 #86x88 & create effect
                anim = eff.animations.add  'explode', [4, 3, 2, 1, 0, 1, 2, 3], 16, false
            when 3
                eff= @gm.add.sprite 50, 100, @effects[n] ,3 #86x88 & create effect
                anim = eff.animations.add  'explode', [3, 2, 1, 0, 1, 2], 12, false

        eff.anchor.setTo(0.5, 0.5) # anchor in the middle of bottom
        anim.onComplete.add(
            ()-> eff.destroy()
            @
        )
        eff.x =  obj.x   #set effect location
        eff.y =  obj.y

        eff.animations.play 'explode'


