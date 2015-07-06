h = React.DOM

class Life extends React.Component
  dirs: [[-1,-1],[-1,0],[-1,1],[0,-1],[0,1],[1,-1],[1,0],[1,1]]
  constructor: (props) ->
    super props
    {grid, options} = props
    {padding, interval} = options
    {left, right, top, bottom} = padding
    width = grid[0].length + left + right
    height = grid.length + top + bottom
    @grid = [0...height].map -> [0...width].map -> false
    grid.forEach (row, r) =>
      row.forEach (cell, c) =>
        @grid[r + top][c + left] = grid[r][c]
    setInterval(@step, interval)
  isAlive: (r, c) ->
    if r in [-1, @grid.length] or c in [-1, @grid[0].length]
      return false
    @grid[r][c]
  step: =>
    @grid = [0...@grid.length].map (r) => [0...@grid[0].length].map (c) =>
      n = @neighborsAlive(r, c)
      if @isAlive(r, c)
        n in [2,3]
      else
        n == 3
    @setState({data: @grid})
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
  render: =>
    {div} = React.DOM
    div null,
      for row, r in @grid
        div className: "row", key: "row#{r}",
          for cell, c in row
            state = (if @isAlive(r, c) then "alive" else "dead")
            div key: "col#{c}", className: "cell #{state}"


grid = [[false,  true,  true],
        [ true,  true, false],
        [false,  true, false]]
options =
  interval: 1000/30
  padding:
    left: 30
    right: 30
    top: 30
    bottom: 30

# game = new Life(grid, options)

# console.log game.isAlive(b, a) for a in [0..2] for b in [0..2]
# console.log game.neighborsAlive(1,1)
# game.step()
# console.log game.toString()
# game.step()
# console.log game.toString()
# game.step()
# console.log game.toString()
# game.step()
# console.log game.toString()
# console.log game.isAlive(b, a) for a in [0..2] for b in [0..2]
# console.log game.neighborsAlive(1,1)

# React.render h.Life, $('#content')
React.render( <Life grid={grid} options={options}/>, document.getElementById('content') )
