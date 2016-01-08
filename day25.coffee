exports.codes = codes = [[20151125]]

exports.lookupCode = lookupCode = (row, col) ->

  if col < 1
    col = row - 2
    row = 1

  codes[row-1] ?= []
  codes[row-1][col-1] ?= findNextCode(lookupCode(row+1, col-1))

  return codes[row-1][col-1]

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
