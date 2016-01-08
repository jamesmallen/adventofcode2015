
module.exports.combinations = combinations = (packages, targetWeight) ->
  ret = []

  for p, i in packages
    if p < targetWeight
      for c in combinations(packages[i+1..], targetWeight - p)
        ret.push([p].concat(c))
    else if p == targetWeight
      ret.push([p])

  return ret


module.exports.sum = sum = (arr) ->
  return arr.reduce((t, s) -> t + s)


module.exports.product = product = (arr) ->
  return arr.reduce((t, s) -> t * s)


module.exports.hasUniqueCombinations = hasUniqueCombinations = (combos, groups=3, used=null) ->
  if groups == 0
    return true

  # copy used
  used = Object.assign({}, used)

  for c, i in combos
    # console.log(c)
    if c.every((x) -> not used[x])
      c.every((x) -> used[x] = true)
      return hasUniqueCombinations(combos[i+1..], groups - 1, used)

  return false


module.exports.fewestPackages = fewestPackages = (packages, divisions=3) ->
  totalWeight = sum(packages)
  targetWeight = totalWeight / divisions

  candidates = combinations(packages, targetWeight)
  candidates.sort((a, b) -> a.length - b.length)

  res = []

  for c, i in candidates
    if res[0]? and c.length > res[0].length
      break
    if hasUniqueCombinations(candidates[i..])
      console.log(c)
      res.push(c)
  return res

module.exports.quantumEntanglement = quantumEntanglement = (packages) ->
  return product(packages)



module.exports.bestArrangement = bestArrangement = (packages, divisions=3) ->
  arrangements = fewestPackages(packages, divisions)
  arrangements.sort((a, b) -> quantumEntanglement(a) - quantumEntanglement(b))

  return arrangements[0]

main = () ->
  rl = require('readline').createInterface(
    input: require('fs').createReadStream('day24input.txt')
  )

  packages = []

  rl.on 'line', (line) ->
    packages.push(parseInt(line))

  rl.on 'close', ->
    console.log(packages)
    # best = bestArrangement(packages)
    # console.log(quantumEntanglement(best))
    best = bestArrangement(packages, 4)
    console.log(quantumEntanglement(best))

if require.main == module
  main()
