
class Phacker.Game.Socle

    constructor: (@gm) ->
        @_fle_ = 'Socle'
        @Pm = @gm.parameters = {}
        @Pm.msg = [] # store all messages

        @pm = @Pm.bg = # background
            y0: 48
            w : if @gm.gameOptions.fullscreen  then 375 else 768
            h : if @gm.gameOptions.fullscreen  then 569 else 512
        @pm.w2 = @pm.w/2 # middle of background
        @pm.x0 = @pm.w2

        @draw_bg()

    #.----------.----------
    # build socle
    #.----------.----------

    draw_bg: ->

        @bg = @gm.add.sprite @pm.x0, @pm.y0, 'bg_gameplay' # 768x500
        @bg.anchor.setTo(0.5, 0) # anchor in the middle of top

    #.----------.----------
    # get all messages
    #.----------.----------

    get_msg: ->
        #console.log @_fle_,': ',@pm.msg_bsks.length
        if  @Pm.msg.length is 0
            return 'none'
        else
            return @Pm.msg.pop()


