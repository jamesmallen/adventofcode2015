

getPossibilities = (base, replacements) ->
  ret = {}

  for r in replacements
    [a, b] = r
    fromIndex = 0
    indexOf = base.indexOf(a, fromIndex)
    while indexOf >= 0
      poss = base[...indexOf] + b + base[indexOf + a.length...]
      ret[poss] = (ret[poss] ? 0) + 1
      fromIndex = indexOf + 1
      indexOf = base.indexOf(a, fromIndex)


  return Object.keys(ret)


walkPossibilities = (target, replacements, base = 'e', steps = 1) ->
  best = null
  if base.length > target.length
    return null
  possibilities = getPossibilities(base, replacements)
  for p in possibilities
    if p == target
      console.log(steps)
      best = steps
    else
      res = walkPossibilities(target, replacements, p, steps + 1)
      if res
        best = best ? res
        if res < best
          best = res
          console.log('better', res)
  return best

module.exports.getPossibilities = getPossibilities

main = () ->
  rl = require('readline').createInterface(
    input: require('fs').createReadStream('day19input.txt')
  )

  replacements = []
  base = ''

  replacementRE = /(\w*) => (\w*)/


  rl.on 'line', (line) ->
    if line.trim() == ''
      return

    match = line.match(replacementRE)
    if match
      replacements.push([match[1], match[2]])
      return

    base = line

  rl.on 'close', ->
    possibilities = getPossibilities(base, replacements)
    # console.log(possibilities)
    console.log(possibilities.length)

    # console.log(walkPossibilities('HOHOHO', [
    #   ['e', 'H']
    #   ['e', 'O']
    #   ['H', 'HO']
    #   ['H', 'OH']
    #   ['O', 'HH']
    # ]))

    console.log(walkPossibilities(base, replacements))


if require.main == module
  main()
