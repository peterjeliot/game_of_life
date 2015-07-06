class Life extends React.Component
  dirs: [[-1,-1],[-1,0],[-1,1],[0,-1],[0,1],[1,-1],[1,0],[1,1]]
  constructor: (props) ->
    super props
    {grid, @options} = props
    {padding, interval, wrap} = @options
    {@left, @right, @top, @bottom} = padding
    @loadSeed("R-Pentomino")
    setInterval(@step, interval)
  loadSeed: (name) =>
    seed = @parse(@options.seeds[name])
    @options.width = seed[0].length + @left + @right
    @options.height = seed.length + @top + @bottom
    @grid = [0...@options.height].map => [0...@options.width].map => false
    seed.forEach (row, r) =>
      row.forEach (cell, c) =>
        @grid[r + @top][c + @left] = cell
    @setState data: @grid
  parse: (string) ->
    lines = string.split("\n")
    lines.map (line) ->
      line.split("").map (char) ->
        char == "*"
  onClick: (event) =>
    @loadSeed(event.currentTarget.value)
  isAlive: (r, c) ->
    if not @options.wrap and (r in [-1, @grid.length] or c in [-1, @grid[0].length])
      return false
    @grid[r %% @options.height][c %% @options.width]
  step: =>
    @grid = [0...@grid.length].map (r) => [0...@grid[0].length].map (c) =>
      n = @neighborsAlive(r, c)
      if @isAlive(r, c)
        n in [2,3]
      else
        n == 3
    @setState data: @grid
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
    {div, input} = React.DOM
    div null,
      div null,
        for name, pattern of @options.seeds
          input type: "button", \
                value: name, \
                onClick: @onClick
      div className: "grid",
        for row, r in @grid
          div className: "row", key: "row#{r}",
            for cell, c in row
              state = (if @isAlive(r, c) then "alive" else "dead")
              div key: "col#{c}", className: "cell #{state}"

seeds =
  "Methuselah": """
     *
       *
    **  ***
  """
  "R-Pentomino": """
     **
    **
     *
  """
  "Glider": """
    ***    ***
    *        *
     *      *


     *      *
    *        *
    ***    ***
  """

grid = [[false,  true,  true],
        [ true,  true, false],
        [false,  true, false]]
options =
  seeds: seeds
  interval: 1000/10
  wrap: true
  padding:
    left: 20
    right: 20
    top: 20
    bottom: 20

life = <Life grid={grid} options={options}/>
React.render( life, document.getElementById('content') )
