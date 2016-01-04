

factors = (n) ->
  factors.cache = factors.cache ? {}
  if factors.cache[n]?
    return factors.cache[n]
  ret = []
  for i in [Math.floor(Math.sqrt(n))..1]
    if n % i == 0
      ret.unshift(i)
      if i != n/i
        ret.push(n/i)
  factors.cache[n] = ret
  return ret

presentsForHouse = (n, lazy=false) ->
  presentCount = 0

  for elfNumber in factors(n)
    if not lazy
      presentCount += elfNumber * 10
    else
      if n <= 50 * elfNumber
        presentCount += elfNumber * 11

  return presentCount




module.exports.presentsForHouse = presentsForHouse

main = () ->
  rl = require('readline').createInterface(
    input: require('fs').createReadStream('day20input.txt')
  )

  minimumPresents = null

  rl.on 'line', (line) ->
    minimumPresents = minimumPresents ? parseInt(line.trim())

  rl.on 'close', ->
    console.log(minimumPresents)
    n = 1
    loop
      presents = presentsForHouse(n, true)
      if n % 100000 == 0
        console.log(n, presents)
      if presents >= minimumPresents
        console.log(n, presents)
        break
      n++

if require.main == module
  main()
