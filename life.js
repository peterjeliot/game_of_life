// Generated by CoffeeScript 1.9.3
(function() {
  var Life, game;

  Life = (function() {
    function Life() {}

    Life.prototype.isAlive = function(r, c) {
      return this.current[r][c];
    };

    Life.prototype.step = function() {
      var future;
      return future = [1, 2, 3, 4, 5, 6, 7, 8, 9].map(function(r) {
        return [1, 2, 3, 4, 5, 6, 7, 8, 9].map(function(c) {
          var n;
          n = neighborsAlive(r, c, this.present);
          if (isAlive(r, c)) {
            return n === 2 || n === 3;
          } else {
            return n === 3;
          }
        });
      });
    };

    return Life;

  })();

  game = new Life;

}).call(this);
