class Phacker.Game.Gate

    constructor: (@gm, @mecO) -> # scl_bdy stands for socle body
        @_fle_ = 'Gate'
        @Pm = @gm.parameters
        @pm = @Pm.gate =
            x1  : @Pm.mec.x0-13 # gate paramaters
            y1  : @Pm.mec.y0 + 148
            x2  : @Pm.mec.x0+13
            y2  : @Pm.mec.y0 + 148
            w   : 14
            h   : 5
            vtta: 400  # velocity of rotation
            mouse_down : false
        @pm.left_vert =  [0, 0, @pm.w, 0] # one line body of 2 part gates
        @pm.right_vert = [0, 0, -@pm.w, 0]

        @gm.input.onDown.add @on_mouse_down, @
        @gm.input.onUp.add   @on_mouse_up, @

        #add sprite gate in game socle body
        @gtl = @mk_2d_spt(@pm.x1, @pm.y1, 'mecanic_door_left',  @pm.left_vert, 'lh')
        @gtr = @mk_2d_spt(@pm.x2, @pm.y1, 'mecanic_door_right', @pm.right_vert,'rh')

#        @gtl_joint = @gm.physics.box2d.revoluteJoint(
#            @mecO.left_body,            @gtl.body
#            @Pm.mec.x2,                 @Pm.mec.y2
#            0,                          0
#            20,                         100,                true,
#            -45,                        45,                 true
#        )

    #.----------.----------
    # make a diamond
    #.----------.----------

    mk_2d_spt:(x, y, frame,  vert, anc)-> # vert as vertecies & stc as static & anc for anchor
        spt = @gm.add.sprite x, y, frame
        spt.scale.setTo 1.4,1
        @gm.physics.box2d.enable spt
        #spt.body.clearFixtures()
        #spt.body.setChain vert # make the body as simple as possible

        if anc is 'lh' then spt. anchor.setTo(0,0)#'lh' as left hight
        else if anc is 'rh' then spt. anchor.setTo(1,0)#'lh' as left hight

        spt.body.kinematic = true
        #tl = new Phacker.Game.Tools @gm
        #tl.show_vertices spt, vert

        return spt

#.----------.----------
# set mouse events
#.----------.----------
    on_mouse_down: ->
        if not @Pm.btn.game_started then return
        if @pm.mouse_down then return
        @pm.mouse_down = true
        @gtl.body.rotateRight @pm.vtta
        @gtr.body.rotateLeft  @pm.vtta

    on_mouse_up: ->
        if not @Pm.btn.game_started then return
        if not @pm.mouse_down then return
        @pm.mouse_down = false
        @gtl.body.rotateLeft  @pm.vtta
        @gtr.body.rotateRight @pm.vtta

    #.----------.----------
    # check gate rotation
    # .----------.----------
    check: ->
        if @pm.mouse_down and @gtl.body.angle > 90
            @gtr.body.angle =  -90
            @gtl.body.angle = 90
            @gtl.body.rotateRight 0
            @gtr.body.rotateRight 0

        else if not  @pm.mouse_down and @gtr.body.angle < 0
            @gtr.body.angle = @gtl.body.angle = 0
            @gtl.body.rotateRight 0
            @gtr.body.rotateRight 0

        #console.log @_fle_,': ',@gtl.body.angle,@gtr.angle

    #.----------.----------
    # bind
    #.----------.----------
    #bind: (mecO) -> @mecO = mecO

