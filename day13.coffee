


calculateHappiness = (deltas, arrangement) ->
  total = 0
  arrangement = arrangement.slice()
  # make extra copies at the ends to simplify calcs
  arrangement.unshift(arrangement[arrangement.length - 1])
  arrangement.push(arrangement[1])

  for i in [1...arrangement.length - 1]
    focusPerson = arrangement[i]
    total += deltas[focusPerson][arrangement[i-1]]
    total += deltas[focusPerson][arrangement[i+1]]

  return total


# http://rosettacode.org/wiki/Permutations

# Returns a copy of an array with the element at a specific position
# removed from it.
arrayExcept = (arr, idx) ->
	res = arr[0..]
	res.splice idx, 1
	res

# The actual function which returns the permutations of an array-like
# object (or a proper array).
permute = (arr) ->
	arr = Array::slice.call arr, 0
	return [[]] if arr.length == 0

	permutations = (for value,idx in arr
		[value].concat perm for perm in permute arrayExcept arr, idx)

	# Flatten the array before returning it.
	[].concat permutations...




calculateOptimalArrangement = (deltas) ->
  bestArrangement = undefined
  bestHappiness = -1
  people = []
  people.push(key) for key, value of deltas
  for arrangement in permute(people)
    # console.log(arrangement)
    happiness = calculateHappiness(deltas, arrangement)
    if happiness > bestHappiness
      bestArrangement = arrangement
      bestHappiness = happiness

  return bestArrangement

deltaRE = /(\w+) would (gain|lose) (\d+) happiness units by sitting next to (\w+)\./


buildDeltas = (deltas, line) ->
  res = line.match(deltaRE)
  if res
    person1 = res[1]
    direction = res[2]
    amount = res[3]
    person2 = res[4]
    multiplier = if direction == 'gain' then 1 else -1
    if not deltas[person1]?
      deltas[person1] = {}
    deltas[person1][person2] = multiplier * amount


module.exports.calculateHappiness = calculateHappiness
module.exports.calculateOptimalArrangement = calculateOptimalArrangement


main = () ->
  rl = require('readline').createInterface(
    input: require('fs').createReadStream('day13input.txt')
  )
  deltas = {}

  rl.on 'line', (line) ->
    buildDeltas(deltas, line)

  rl.on 'close', ->
    arrangement = calculateOptimalArrangement(deltas)
    console.log(arrangement)
    happiness = calculateHappiness(deltas, arrangement)
    console.log(happiness)

    deltas['me'] = {}
    for person, value of deltas
      deltas['me'][person] = 0
      deltas[person]['me'] = 0
    arrangement = calculateOptimalArrangement(deltas)
    console.log(arrangement)
    happiness = calculateHappiness(deltas, arrangement)
    console.log(happiness)

if require.main == module
  main()
