class Life
  dirs: [[-1,-1],[-1,0],[-1,1],[0,-1],[0,1],[1,-1],[1,0],[1,1]]
  constructor: (grid) ->
    @grid = grid
  isAlive: (r, c) ->
    if r in [-1, @grid.length] or c in [-1, @grid[0].length]
      return false
    @grid[r][c]
  step: ->
    @grid = [0...@grid.length].map (r) => [0...@grid[0].length].map (c) =>
      n = @neighborsAlive(r, c)
      if @isAlive(r, c)
        n in [2,3]
      else
        n == 3
  neighborsAlive: (r, c) ->
    @dirs.map(([dr, dc]) =>
      @isAlive(r+dr, c+dc) ? 1 : 0
    ).reduce (a, b) -> (a + b)
  toString: ->
    "\n" +
    @grid.map (row, r) ->
      " " +
      row.map (cell, c) -> (if cell then "*" else ".")
      .reduce (a, b) -> (a + b)
    .reduce (a, b) -> (a + "\n" + b)






game = new Life([[false, false, false],
                 [ true,  true,  true],
                 [false, false, false]])

# console.log game.isAlive(b, a) for a in [0..2] for b in [0..2]
# console.log game.neighborsAlive(1,1)
game.step()
console.log game.toString()
game.step()
console.log game.toString()
game.step()
console.log game.toString()
game.step()
console.log game.toString()
# console.log game.isAlive(b, a) for a in [0..2] for b in [0..2]
# console.log game.neighborsAlive(1,1)
