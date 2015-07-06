// Generated by CoffeeScript 1.9.3
(function() {
  var Life, grid, h, options,
    bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
    extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    hasProp = {}.hasOwnProperty;

  h = React.DOM;

  Life = (function(superClass) {
    extend(Life, superClass);

    Life.prototype.dirs = [[-1, -1], [-1, 0], [-1, 1], [0, -1], [0, 1], [1, -1], [1, 0], [1, 1]];

    function Life(props) {
      this.render = bind(this.render, this);
      this.step = bind(this.step, this);
      var bottom, grid, height, i, interval, left, options, padding, results, right, top, width;
      Life.__super__.constructor.call(this, props);
      grid = props.grid, options = props.options;
      padding = options.padding, interval = options.interval;
      left = padding.left, right = padding.right, top = padding.top, bottom = padding.bottom;
      width = grid[0].length + left + right;
      height = grid.length + top + bottom;
      this.grid = (function() {
        results = [];
        for (var i = 0; 0 <= height ? i < height : i > height; 0 <= height ? i++ : i--){ results.push(i); }
        return results;
      }).apply(this).map(function() {
        var i, results;
        return (function() {
          results = [];
          for (var i = 0; 0 <= width ? i < width : i > width; 0 <= width ? i++ : i--){ results.push(i); }
          return results;
        }).apply(this).map(function() {
          return false;
        });
      });
      grid.forEach((function(_this) {
        return function(row, r) {
          return row.forEach(function(cell, c) {
            return _this.grid[r + top][c + left] = grid[r][c];
          });
        };
      })(this));
      setInterval(this.step, interval);
    }

    Life.prototype.isAlive = function(r, c) {
      if ((r === (-1) || r === this.grid.length) || (c === (-1) || c === this.grid[0].length)) {
        return false;
      }
      return this.grid[r][c];
    };

    Life.prototype.step = function() {
      var i, ref, results;
      this.grid = (function() {
        results = [];
        for (var i = 0, ref = this.grid.length; 0 <= ref ? i < ref : i > ref; 0 <= ref ? i++ : i--){ results.push(i); }
        return results;
      }).apply(this).map((function(_this) {
        return function(r) {
          var i, ref, results;
          return (function() {
            results = [];
            for (var i = 0, ref = _this.grid[0].length; 0 <= ref ? i < ref : i > ref; 0 <= ref ? i++ : i--){ results.push(i); }
            return results;
          }).apply(this).map(function(c) {
            var n;
            n = _this.neighborsAlive(r, c);
            if (_this.isAlive(r, c)) {
              return n === 2 || n === 3;
            } else {
              return n === 3;
            }
          });
        };
      })(this));
      return this.setState({
        data: this.grid
      });
    };

    Life.prototype.neighborsAlive = function(r, c) {
      return this.dirs.map((function(_this) {
        return function(arg) {
          var dc, dr, ref;
          dr = arg[0], dc = arg[1];
          return (ref = _this.isAlive(r + dr, c + dc)) != null ? ref : {
            1: 0
          };
        };
      })(this)).reduce(function(a, b) {
        return a + b;
      });
    };

    Life.prototype.toString = function() {
      return "\n" + this.grid.map(function(row, r) {
        return " " + row.map(function(cell, c) {
          if (cell) {
            return "*";
          } else {
            return ".";
          }
        }).reduce(function(a, b) {
          return a + b;
        });
      }).reduce(function(a, b) {
        return a + "\n" + b;
      });
    };

    Life.prototype.render = function() {
      var c, cell, div, r, row, state;
      div = React.DOM.div;
      return div(null, (function() {
        var i, len, ref, results;
        ref = this.grid;
        results = [];
        for (r = i = 0, len = ref.length; i < len; r = ++i) {
          row = ref[r];
          results.push(div({
            className: "row",
            key: "row" + r
          }, (function() {
            var j, len1, results1;
            results1 = [];
            for (c = j = 0, len1 = row.length; j < len1; c = ++j) {
              cell = row[c];
              state = (this.isAlive(r, c) ? "alive" : "dead");
              results1.push(div({
                key: "col" + c,
                className: "cell " + state
              }));
            }
            return results1;
          }).call(this)));
        }
        return results;
      }).call(this));
    };

    return Life;

  })(React.Component);

  grid = [[false, true, true], [true, true, false], [false, true, false]];

  options = {
    interval: 1000 / 30,
    padding: {
      left: 30,
      right: 30,
      top: 30,
      bottom: 30
    }
  };

  React.render(React.createElement(Life, {
    "grid": grid,
    "options": options
  }), document.getElementById('content'));

}).call(this);
