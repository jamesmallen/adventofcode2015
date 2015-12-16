


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

module.exports.calculateHappiness = calculateHappiness
module.exports.calculateOptimalArrangement = calculateOptimalArrangement


main = () ->
  rl = require('readline').createInterface(
    input: require('fs').createReadStream('day13input.txt')
  )
  res = ''

  rl.on 'line', (line) ->
    for [1..2]
      line = nextValidpassword(line)
      console.log(line)


  rl.on 'close', ->
    # TODO
if require.main == module
  main()
