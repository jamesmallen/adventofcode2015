
hasRed = (x) ->
  if typeof(x) != 'string' and x not instanceof Array
    for key, value of x
      if value == 'red'
        return true
  else
    return false


sumNodes = (x, skipRed=false) ->
  if typeof(x) == 'number'
    return x
  else if typeof(x) == 'string'
    return 0
  else if x instanceof Array
    total = 0
    total += sumNodes(y, skipRed) for y in x
    return total
  else
    if skipRed and hasRed(x)
      return 0
    total = 0
    total += sumNodes(y, skipRed) + sumNodes(z, skipRed) for y, z of x
    return total



module.exports.sumNodes = sumNodes
module.exports.hasRed = hasRed


main = () ->
  inputDoc = JSON.parse(require('fs').readFileSync('./day12input.txt', 'utf8'))

  console.log(sumNodes(inputDoc))
  console.log(sumNodes(inputDoc, true))

if require.main == module
  main()
