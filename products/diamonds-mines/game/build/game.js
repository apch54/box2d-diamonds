(function() {
  Phacker.Game.Tools = (function() {
    function Tools(gm) {
      this.gm = gm;
      this._fle_ = 'Tools';
    }

    Tools.prototype.show_vertices = function(obj, ary) {
      var ii, l, results;
      if ((l = ary.length) < 2) {
        return;
      }
      ii = 0;
      results = [];
      while (ii < l / 2) {
        this.mk_rect(obj.x + ary[2 * ii], obj.y + ary[2 * ii + 1]);
        results.push(ii++);
      }
      return results;
    };

    Tools.prototype.mk_rect = function(x, y) {
      var b, s;
      b = this.gm.add.bitmapData(3, 3);
      b.ctx.beginPath();
      b.ctx.rect(0, 0, 10, 10);
      b.ctx.fillStyle = '#00ff00';
      b.ctx.fill();
      s = this.gm.add.sprite(x, y, b);
      s.anchor.setTo(.5, .5);
      return s;
    };

    return Tools;

  })();

}).call(this);

(function() {
  Phacker.Game.Socle = (function() {
    function Socle(gm) {
      this.gm = gm;
      this._fle_ = 'Socle';
      this.Pm = this.gm.parameters = {};
      this.pm = this.Pm.bg = {
        y0: 48,
        w: this.gm.gameOptions.fullscreen ? 375 : 768,
        h: this.gm.gameOptions.fullscreen ? 569 : 512
      };
      this.pm.w2 = this.pm.w / 2;
      this.pm.x0 = this.pm.w2;
      this.draw_bg();
    }

    Socle.prototype.draw_bg = function() {
      this.bg = this.gm.add.sprite(this.pm.x0, this.pm.y0, 'bg_gameplay');
      return this.bg.anchor.setTo(0.5, 0);
    };

    return Socle;

  })();

}).call(this);

(function() {
  Phacker.Game.Rope = (function() {
    function Rope(gm) {
      this.gm = gm;
      this._fle_ = 'Rope';
      this.Pm = this.gm.parameters;
      this.pm = this.Pm.rope = {
        x0: this.Pm.bg.w2,
        w: 329,
        h: 375,
        r: 20
      };
      this.pm.y0 = this.gm.gameOptions.fullscreen ? this.Pm.bg.y0 + 50 : this.Pm.bg.y0 + 20;
      this.pm.w2 = this.pm.w / 2;
      this.pmw = this.Pm.whl = {
        x1: this.pm.x0 - this.pm.w2 + this.pm.r,
        y1: this.pm.y0 + this.pm.r,
        x2: this.pm.x0 + this.pm.w2 - this.pm.r
      };
      this.pmw.y2 = this.pmw.y1;
      this.pmw.x3 = this.pmw.x2;
      this.pmw.y3 = this.pm.y0 + this.pm.h - this.pm.r;
      this.pmw.x4 = this.pmw.x1;
      this.pmw.y4 = this.pmw.y3;
      this.draw();
    }

    Rope.prototype.draw = function() {
      this.rop = this.gm.add.sprite(this.pm.x0, this.pm.y0, 'rope');
      this.rop.anchor.setTo(0.5, 0);
      this.whl1 = this.gm.add.sprite(this.pmw.x1, this.pmw.y1, 'wheel');
      this.whl1.anchor.setTo(0.5, 0.5);
      this.mk_tween(this.whl1, {
        angle: 360
      }, 1700);
      this.whl2 = this.gm.add.sprite(this.pmw.x2, this.pmw.y2, 'wheel');
      this.whl2.anchor.setTo(0.5, 0.5);
      this.mk_tween(this.whl2, {
        angle: 360
      }, 1800);
      this.whl3 = this.gm.add.sprite(this.pmw.x3, this.pmw.y3, 'wheel');
      this.whl3.anchor.setTo(0.5, 0.5);
      this.mk_tween(this.whl3, {
        angle: 360
      }, 1900);
      this.whl4 = this.gm.add.sprite(this.pmw.x4, this.pmw.y4, 'wheel');
      this.whl4.anchor.setTo(0.5, 0.5);
      return this.mk_tween(this.whl4, {
        angle: 360
      }, 2000);
    };

    Rope.prototype.mk_tween = function(spt, lst, t) {
      var tw;
      tw = this.gm.add.tween(spt);
      return tw.to(lst, t, Phaser.Easing.Linear.None, true, 0, -1);
    };

    return Rope;

  })();

}).call(this);


/*  written by apch on 2017-05-06
       ... --- ...
      |          ,---------------------------------.
      |.===.     | an other one : Diamonds mines   |
      {}o o{}    _)--------------------------------'
   ooO--(_)--Ooo-
 */

(function() {
  Phacker.Game.Bottom = (function() {
    function Bottom(gm) {
      this.gm = gm;
      this._fle_ = 'Bottom';
      this.Pm = this.gm.parameters;
      this.pm = this.Pm.btm = {
        x0: this.Pm.bg.w2,
        w: 375,
        h: 27
      };
      this.pm.y0 = this.Pm.bg.h - this.pm.h;
      this.pm.w2 = this.pm.w / 2;
      this.pm.h2 = this.pm.h / 2;
      this.vertices = [-this.pm.w2, 0, 0, -this.pm.h2, this.pm.w2, 0];
      this.btm = this.draw_btm();
    }

    Bottom.prototype.draw_btm = function() {
      var btm;
      btm = this.gm.add.sprite(this.pm.x0, this.pm.y0, 'platform');
      this.gm.physics.box2d.enable(btm);
      btm.body["static"] = true;
      btm.body.fixedRotation = true;
      btm.body.setChain(this.vertices);
      return btm;
    };

    return Bottom;

  })();

}).call(this);

(function() {
  Phacker.Game.Mecanic = (function() {
    function Mecanic(gm) {
      this.gm = gm;
      this._fle_ = 'Socle';
      this.Pm = this.gm.parameters;
      this.pm = this.Pm.mec = {
        x0: this.Pm.bg.w2,
        y0: this.Pm.bg.y0 + 105,
        w: 283,
        h: 150
      };
      this.pm.x1 = this.pm.x0 - this.pm.w / 2 + 2;
      this.pm.y1 = this.pm.y0 + 88;
      this.pm.x2 = this.pm.x0 - 13;
      this.pm.y2 = this.pm.y1 + 32;
      this.pm.x3 = this.pm.x2;
      this.pm.y3 = this.pm.y2 + 30;
      this.pm.x3 = this.pm.x2;
      this.pm.y3 = this.pm.y2 + 30;
      this.pm.x4 = 2 * this.pm.x0 - this.pm.x3 + 2;
      this.pm.y4 = this.pm.y3;
      this.pm.x5 = this.pm.x4;
      this.pm.y5 = this.pm.y2;
      this.pm.x6 = 2 * this.pm.x0 - this.pm.x1 - 1;
      this.pm.y6 = this.pm.y1;
      this.draw();
      this.mk_bodies();
    }

    Mecanic.prototype.draw = function() {
      this.mec = this.gm.add.sprite(this.pm.x0, this.pm.y0, 'mecanic');
      return this.mec.anchor.setTo(0.5, 0);
    };

    Mecanic.prototype.mk_bodies = function() {
      this.pm.left_vtx = [this.pm.x1, this.pm.y1 - 20, this.pm.x1, this.pm.y1, this.pm.x2, this.pm.y2, this.pm.x3, this.pm.y3];
      this.left_body = new Phaser.Physics.Box2D.Body(this.gm, null, 0, 0, 0);
      this.left_body.setChain(this.pm.left_vtx);
      this.pm.right_vtx = [this.pm.x6, this.pm.y6 - 20, this.pm.x6, this.pm.y6, this.pm.x5, this.pm.y5, this.pm.x4, this.pm.y4];
      this.right_body = new Phaser.Physics.Box2D.Body(this.gm, null, 0, 0, 0);
      return this.right_body.setChain(this.pm.right_vtx);
    };

    return Mecanic;

  })();

}).call(this);


/*  written by apch  on 2017-05-31 */

(function() {
  Phacker.Game.Buttom = (function() {
    function Buttom(gm) {
      this.gm = gm;
      this._fle_ = 'Button';
      this.pm = this.gm.parameters.btn = {
        x: this.gm.parameters.mec.x0 - 35,
        y: this.gm.parameters.mec.y0 + 180,
        w: 72,
        h: 72,
        game_started: false
      };
      this.draw_button();
    }

    Buttom.prototype.draw_button = function() {
      return this.btn = this.gm.add.button(this.pm.x, this.pm.y, 'start_btn', this.on_tap, this, 1, 1, 0);
    };

    Buttom.prototype.on_tap = function() {
      this.bsksO.mk_bsk();
      this.btn.y = 800;
      this.btn.alpha = 0;
      return this.pm.game_started = true;
    };

    Buttom.prototype.bind = function(bsks) {
      return this.bsksO = bsks;
    };

    return Buttom;

  })();

}).call(this);

(function() {
  Phacker.Game.Gate = (function() {
    function Gate(gm, mecO) {
      this.gm = gm;
      this.mecO = mecO;
      this._fle_ = 'Gate';
      this.Pm = this.gm.parameters;
      this.pm = this.Pm.gate = {
        x1: this.Pm.mec.x0 - 13,
        y1: this.Pm.mec.y0 + 148,
        x2: this.Pm.mec.x0 + 13,
        y2: this.Pm.mec.y0 + 148,
        w: 14,
        h: 5,
        vtta: 400,
        mouse_down: false
      };
      this.pm.left_vert = [0, 0, this.pm.w, 0];
      this.pm.right_vert = [0, 0, -this.pm.w, 0];
      this.gm.input.onDown.add(this.on_mouse_down, this);
      this.gm.input.onUp.add(this.on_mouse_up, this);
      this.gtl = this.mk_2d_spt(this.pm.x1, this.pm.y1, 'mecanic_door_left', this.pm.left_vert, 'lh');
      this.gtr = this.mk_2d_spt(this.pm.x2, this.pm.y1, 'mecanic_door_right', this.pm.right_vert, 'rh');
    }

    Gate.prototype.mk_2d_spt = function(x, y, frame, vert, anc) {
      var spt;
      spt = this.gm.add.sprite(x, y, frame);
      spt.scale.setTo(1.4, 1);
      this.gm.physics.box2d.enable(spt);
      if (anc === 'lh') {
        spt.anchor.setTo(0, 0);
      } else if (anc === 'rh') {
        spt.anchor.setTo(1, 0);
      }
      spt.body.kinematic = true;
      return spt;
    };

    Gate.prototype.on_mouse_down = function() {
      if (!this.Pm.btn.game_started) {
        return;
      }
      if (this.pm.mouse_down) {
        return;
      }
      this.pm.mouse_down = true;
      this.gtl.body.rotateRight(this.pm.vtta);
      return this.gtr.body.rotateLeft(this.pm.vtta);
    };

    Gate.prototype.on_mouse_up = function() {
      if (!this.Pm.btn.game_started) {
        return;
      }
      if (!this.pm.mouse_down) {
        return;
      }
      this.pm.mouse_down = false;
      this.gtl.body.rotateLeft(this.pm.vtta);
      return this.gtr.body.rotateRight(this.pm.vtta);
    };

    Gate.prototype.check = function() {
      if (this.pm.mouse_down && this.gtl.body.angle > 90) {
        this.gtr.body.angle = -90;
        this.gtl.body.angle = 90;
        this.gtl.body.rotateRight(0);
        return this.gtr.body.rotateRight(0);
      } else if (!this.pm.mouse_down && this.gtr.body.angle < 0) {
        this.gtr.body.angle = this.gtl.body.angle = 0;
        this.gtl.body.rotateRight(0);
        return this.gtr.body.rotateRight(0);
      }
    };

    return Gate;

  })();

}).call(this);

(function() {
  Phacker.Game.Diamonds = (function() {
    function Diamonds(gm, btmO) {
      this.gm = gm;
      this.btmO = btmO;
      this._fle_ = 'Diamonds';
      this.Pm = this.gm.parameters;
      this.pm = this.Pm.dmds = {
        w: 10,
        h: 10,
        n_in: 0,
        max_in: 15,
        last_used: -1,
        n: 97,
        dmd_in_game: 15,
        names: ['blue_ball', 'green_ball', 'pink_ball', 'red_ball', 'yellow_ball'],
        x1: this.Pm.mec.x0 - this.Pm.mec.w / 2 + 9,
        x2: this.Pm.mec.x0 - 18,
        x3: this.Pm.mec.x0 + this.Pm.mec.w / 2 - 49,
        y1: this.Pm.mec.y0 + 68,
        msg_n: 'ok'
      };
      this.dmds = [];
      this.mk_all_dmd();
    }

    Diamonds.prototype.check = function() {
      if (!this.Pm.btn.game_started) {
        return;
      }
      if (this.pm.n_in < this.pm.max_in && this.pm.last_used < this.pm.n) {
        this.pm.last_used++;
        this.dmds[this.pm.last_used].body["static"] = false;
        return this.pm.n_in++;
      }
    };

    Diamonds.prototype.mk_all_dmd = function() {
      var col, col1, col2, col3, dmd, i, j, ref, results, x, y;
      col1 = this.gm.rnd.integerInRange(0, 4);
      col2 = (col1 + 1) % 5;
      col3 = (col1 + 2) % 5;
      results = [];
      for (i = j = 0, ref = this.pm.n; 0 <= ref ? j <= ref : j >= ref; i = 0 <= ref ? ++j : --j) {
        if (i < 28) {
          col = col1;
          if ((i % 4) === 0) {
            x = this.pm.x2;
            y = this.pm.y1 - Math.floor(i / 4) * 10;
          } else {
            x += 10;
          }
        } else if (i < 63) {
          col = col2;
          if ((i - 28) % 5 === 0) {
            x = this.pm.x1;
            y = this.pm.y1 - Math.floor((i - 28) / 5) * 10;
          } else {
            x += 10;
          }
        } else if (i < 98) {
          col = col3;
          if ((i - 63) % 5 === 0) {
            x = this.pm.x3;
            y = this.pm.y1 - Math.floor((i - 63) / 5) * 10;
          } else {
            x += 10;
          }
        }
        dmd = this.mk_dmd(x, y, this.pm.names[col]);
        results.push(this.dmds.push(dmd));
      }
      return results;
    };

    Diamonds.prototype.mk_dmd = function(x, y, frame) {
      var spt;
      spt = this.gm.add.sprite(x, y, frame);
      this.gm.physics.box2d.enable(spt);
      spt.body.setCircle(spt.width / 2);
      spt.body.friction = 0.01;
      spt.body["static"] = true;
      spt.body.pm = {};
      spt.body.pm.n = this.dmds.length;
      spt.body.pm.dead = false;
      spt.body.friction = 0.01;
      spt.body.setBodyContactCallback(this.btmO.btm, this.btmCallback, this);
      return spt;
    };

    Diamonds.prototype.btmCallback = function(dmdb, btmb, fixture1, fixture2, begin) {
      if (dmdb.pm.dead) {
        return;
      }
      dmdb.pm.dead = true;
      return this.pm.n_in--;
    };

    return Diamonds;

  })();

}).call(this);

(function() {
  Phacker.Game.Baskets = (function() {
    function Baskets(gm) {
      this.gm = gm;
      this._fle_ = 'Baskets';
      this.Pm = this.gm.parameters;
      this.pm = this.Pm.bsks = {
        x1: this.Pm.rope.x0 - this.Pm.rope.w / 2 + 2,
        y1: this.gm.parameters.rope.y0 + 2,
        x2: this.Pm.rope.x0 + this.Pm.rope.w / 2 - 2,
        y2: this.gm.parameters.rope.y0 + 2,
        x3: this.Pm.rope.x0 + this.Pm.rope.w / 2 - 2,
        y3: this.gm.parameters.rope.y0 + this.Pm.rope.h - 10,
        x4: this.Pm.rope.x0 - this.Pm.rope.w / 2 + 2,
        y4: this.gm.parameters.rope.y0 + this.Pm.rope.h - 2,
        n: 6,
        v: this.gm.gameOptions.vx0
      };
      this.bska = [];
    }

    Baskets.prototype.mk_bsk = function() {
      var bkO;
      return this.bska.push(bkO = new Phacker.Game.OneBasket(this.gm, {
        x: this.pm.x2,
        y: this.pm.y2,
        branch: 'E'
      }));
    };

    Baskets.prototype.move = function() {
      var b, i, l, len, li, ref, results;
      if ((l = this.bska.length) < this.pm.n) {
        b = this.bska[l - 1].bsk;
        li = 2 * (this.Pm.rope.w + this.Pm.rope.h) / this.pm.n;
        if (this.gm.math.fuzzyEqual(b.y - this.pm.y2, li, 4)) {
          this.mk_bsk();
        }
      }
      ref = this.bska;
      results = [];
      for (i = 0, len = ref.length; i < len; i++) {
        b = ref[i];
        results.push(b.move());
      }
      return results;
    };

    return Baskets;

  })();

}).call(this);

(function() {
  Phacker.Game.OneBasket = (function() {
    function OneBasket(gm, lstP1) {
      this.gm = gm;
      this.lstP = lstP1;
      this._fle_ = 'One bsk';
      this.Pm = this.gm.parameters;
      this.pm = this.Pm.bsk = {
        xrot1: this.Pm.rope.x0 - 70,
        xrot2: this.Pm.rope.x0 + this.Pm.rope.w / 6,
        w: 42,
        h: 54,
        v: this.Pm.bsks.v,
        names: ['blue_basket', 'green_basket', 'normal_basket', 'pink_basket', 'red_basket']
      };
      this.vertices = [-this.pm.w / 2 + 4, -this.pm.h / 2, -this.pm.w / 2 + 10, this.pm.h / 2 - 5, this.pm.w / 2 - 10, this.pm.h / 2 - 5, this.pm.w / 2 - 4, -this.pm.h / 2];
      this.bsk = {};
      this.mk_bsk(this.lstP);
    }

    OneBasket.prototype.mk_bsk = function(lstP) {
      var col;
      col = this.gm.rnd.integerInRange(0, 4);
      this.bsk = this.gm.add.sprite(lstP.x, lstP.y, this.pm.names[col]);
      this.gm.physics.box2d.enable(this.bsk);
      this.bsk.body.setChain(this.vertices);
      this.bsk.body.kinematic = true;
      this.bsk.body.friction = 0.01;
      this.bsk.body.pm = {};
      this.bsk.body.pm.branch = lstP.branch;
      this.bsk.body.pm.color = col;
      this.bsk.body.pm.down = false;
      if (this.bsk.body.pm.branch === 'E') {
        this.bsk.body.setZeroVelocity();
        return this.bsk.body.moveDown(this.pm.v);
      } else if (this.bsk.body.pm.branch === 'S') {
        this.bsk.body.setZeroVelocity();
        return this.bsk.body.moveLeft(this.pm.v);
      } else if (this.bsk.body.pm.branch === 'W') {
        this.bsk.body.setZeroVelocity();
        return this.bsk.body.moveUp(this.pm.v);
      } else if (this.bsk.body.pm.branch === 'N') {
        this.bsk.body.setZeroVelocity();
        return this.bsk.body.moveRight(this.pm.v);
      }
    };

    OneBasket.prototype.move = function() {
      if (this.bsk.body.pm.branch === 'N' && this.bsk.x > this.Pm.bsks.x2) {
        this.bsk.body.setZeroVelocity();
        this.bsk.body.moveDown(this.pm.v);
        return this.bsk.body.pm.branch = 'E';
      } else if (this.bsk.body.pm.branch === 'E' && this.bsk.y > this.Pm.bsks.y3) {
        this.bsk.body.setZeroVelocity();
        this.bsk.body.moveLeft(this.pm.v);
        return this.bsk.body.pm.branch = 'S';
      } else if (this.bsk.body.pm.branch === 'S' && this.bsk.x < this.Pm.bsks.x4) {
        this.bsk.body.setZeroVelocity();
        this.bsk.body.moveUp(this.pm.v);
        return this.bsk.body.pm.branch = 'W';
      } else if (this.bsk.body.pm.branch === 'W' && this.bsk.y < this.Pm.bsks.y1) {
        console.log(this._fle_, ': ', this.bsk.y, this.Pm.bsks.y1);
        this.bsk.body.setZeroVelocity();
        this.bsk.body.moveRight(this.pm.v);
        return this.bsk.body.pm.branch = 'N';
      }
    };

    return OneBasket;

  })();

}).call(this);

(function() {
  var extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    hasProp = {}.hasOwnProperty;

  this.YourGame = (function(superClass) {
    extend(YourGame, superClass);

    function YourGame() {
      return YourGame.__super__.constructor.apply(this, arguments);
    }

    YourGame.prototype.update = function() {
      YourGame.__super__.update.call(this);
      this.gateO.check();
      this.diamondsO.check();
      if (this.buttonO.pm.game_started) {
        return this.basketsO.move();
      }
    };

    YourGame.prototype.resetPlayer = function() {
      return console.log("Reset the player");
    };

    YourGame.prototype.create = function() {
      YourGame.__super__.create.call(this);
      this._fle_ = 'create';
      this.game.physics.startSystem(Phaser.Physics.BOX2D);
      this.game.physics.box2d.gravity.y = 1000;
      this.socleO = new Phacker.Game.Socle(this.game);
      this.ropeO = new Phacker.Game.Rope(this.game);
      this.bottomO = new Phacker.Game.Bottom(this.game);
      this.mecanicO = new Phacker.Game.Mecanic(this.game);
      this.buttonO = new Phacker.Game.Buttom(this.game);
      this.gateO = new Phacker.Game.Gate(this.game, this.mecanicO);
      this.basketsO = new Phacker.Game.Baskets(this.game);
      this.diamondsO = new Phacker.Game.Diamonds(this.game, this.bottomO);
      return this.buttonO.bind(this.basketsO);
    };

    return YourGame;

  })(Phacker.GameState);

}).call(this);
