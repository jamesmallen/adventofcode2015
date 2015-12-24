
# module.exports.calculateScore = calculateScore
# module.exports.findBestScore = findBestScore
# module.exports.combos = combos

matchCriteria = (criteria, o) ->
  for key, value of o
    if criteria[key]? and criteria[key] != value
      return false

  return true

matchRetro = (criteriaEqual, criteriaGreater, criteriaFewer, o) ->
  for key, value of o
    if criteriaEqual[key]? and criteriaEqual[key] != value
      return false
    if criteriaGreater[key]? and criteriaGreater[key] >= value
      return false
    if criteriaFewer[key]? and criteriaFewer[key] <= value
      return false

  return true


module.exports.matchCriteria = matchCriteria

main = () ->
  rl = require('readline').createInterface(
    input: require('fs').createReadStream('day16input.txt')
  )

  lineRE = /Sue (\d+): (\w+): (\d+), (\w+): (\d+), (\w+): (\d+)/
  sues = {}

  criteria = {
    children: 3
    cats: 7
    samoyeds: 2
    pomeranians: 3
    akitas: 0
    vizslas: 0
    goldfish: 5
    trees: 3
    cars: 2
    perfumes: 1
  }

  criteriaEqual = {
    children: 3
    samoyeds: 2
    akitas: 0
    vizslas: 0
    cars: 2
    perfumes: 1
  }
  criteriaGreater = {
    cats: 7
    trees: 3
  }
  criteriaFewer = {
    pomeranians: 3
    goldfish: 5
  }

  rl.on 'line', (line) ->
    res = line.match(lineRE)
    if res
      [throwaway, id, key1, val1, key2, val2, key3, val3] = res
      sues[id] = {}
      sues[id][key1] = parseInt(val1)
      sues[id][key2] = parseInt(val2)
      sues[id][key3] = parseInt(val3)
  rl.on 'close', ->
    # console.log(sues)
    for key, sue of sues
      if matchCriteria(criteria, sue)
        console.log(key, sue)

    for key, sue of sues
      if matchRetro(criteriaEqual, criteriaGreater, criteriaFewer, sue)
        console.log(key, sue)

if require.main == module
  main()
