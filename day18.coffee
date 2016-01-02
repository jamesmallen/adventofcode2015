
class LightGrid
  constructor: (initialState, stuckLights) ->
    @grid = initialState.split('\n')
    @stuckLights = stuckLights ? []
    @stickLights()

  stickLights: ->
    for coords in @stuckLights
      @set(coords[0], coords[1], '#')

  toString: ->
    return @grid.join('\n')

  get: (row, col) ->
    if row < 0 or row >= @grid.length or col < 0 or col >= @grid[0].length
      return null

    return @grid[row][col]

  set: (row, col, value) ->
    if row < 0 or row >= @grid.length or col < 0 or col >= @grid[0].length
      return

    @grid[row] = @grid[row][...col] + value + @grid[row][col+1...]

  lightsOn: ->
    count = 0
    for row in @grid
      count += row.split('#').length - 1
    return count

  countNeighbors: (row, col) ->
    count = 0
    for checkRow in [row - 1..row + 1]
      for checkCol in [col - 1..col + 1]
        if checkRow == row and checkCol == col
          continue
        else
          if @get(checkRow, checkCol) == '#'
            count++
    return count

  tick: ->
    newGrid = new LightGrid(@toString())

    for row in [0...@grid.length]
      for col in [0...@grid[0].length]
        neighbors = @countNeighbors(row, col)
        if @get(row, col) == '#'
          if neighbors < 2 or neighbors > 3
            newGrid.set(row, col, '.')
        else
          if neighbors == 3
            newGrid.set(row, col, '#')

    @grid = newGrid.grid
    @stickLights()







module.exports.LightGrid = LightGrid


main = () ->
  rl = require('readline').createInterface(
    input: require('fs').createReadStream('day18input.txt')
  )

  initialGrid = ''

  rl.on 'line', (line) ->
    initialGrid += line + '\n'

  rl.on 'close', ->
    grid = new LightGrid(initialGrid.trim())
    stuckGrid = new LightGrid(initialGrid.trim(), [
      [0, 0]
      [0, 99]
      [99, 0]
      [99, 99]
    ])
    # console.log(grid.toString())
    for _ in [0...100]
      grid.tick()
      stuckGrid.tick()
      # console.log(grid.toString())
    console.log(grid.lightsOn())
    console.log(stuckGrid.lightsOn())


if require.main == module
  main()
