exports.codes = codes = [[20151125]]

lastRow = 1
lastCol = 1

exports.lookupCode = lookupCode = (targetRow, targetCol) ->
  if not codes[targetRow-1]?[targetCol-1]?

    row = lastRow
    col = lastCol

    while not codes[targetRow-1]?[targetCol-1]?
      row--
      col++
      if row < 1
        row = col
        col = 1
      codes[row-1] ?= []
      codes[row-1][col-1] = findNextCode(codes[lastRow-1][lastCol-1])
      lastRow = row
      lastCol = col
      # console.log(codes)
  return codes[targetRow-1][targetCol-1]

exports.findNextCode = findNextCode = (code) ->
  return (code * 252533) % 33554393



main = () ->
  rl = require('readline').createInterface(
    input: require('fs').createReadStream('day25input.txt')
  )

  row = 1
  col = 1

  rl.on 'line', (line) ->
    console.log(line)
    res = line.match(/row (\d+), column (\d+)/)
    if res
      row = parseInt(res[1])
      col = parseInt(res[2])

  rl.on 'close', ->
    console.log(row, col)
    console.log(lookupCode(row, col))

if require.main == module
  main()
