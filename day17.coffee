
countCombinations = (containers, totalAmount, chain) ->
  # ret = []
  counter = 0
  chain = chain? or []
  for c, i in containers
    if c == totalAmount
      counter++
    if c < totalAmount
      counter += countCombinations(containers[i+1...], totalAmount - c)

  return counter

findCombinations = (containers, totalAmount, chain, combos) ->
  chain ?= []
  combos ?= []
  for c, i in containers
    if c == totalAmount
      combos.push(chain.concat([c]))
    if c < totalAmount
      findCombinations(containers[i+1...], totalAmount - c, chain.concat([c]), combos)

  return combos

module.exports.countCombinations = countCombinations
module.exports.findCombinations = findCombinations

main = () ->
  rl = require('readline').createInterface(
    input: require('fs').createReadStream('day17input.txt')
  )


  containers = []

  rl.on 'line', (line) ->
    containers.push(parseInt(line))

  rl.on 'close', ->
    combinations = findCombinations(containers, 150)
    console.log(combinations.length)
    minimumContainers = containers.length
    mimimumCombos = null
    for c in combinations
      if c.length < minimumContainers
        minimumContainers = c.length
        minimumCombos = [c]
      else if c.length == minimumContainers
        minimumCombos.push(c)

    console.log(minimumCombos.length)


if require.main == module
  main()
