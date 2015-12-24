
calculateScore = (ingredients, amounts) ->
  properties = {}
  for key, amount of amounts
    for property of ingredients[key]

      properties[property] = (properties[property] ? 0) + amount * ingredients[key][property]

  # console.log(properties)
  totalScore = 1
  for key, value of properties
    if key == 'calories'
      continue
    if value < 0
      value = 0
    totalScore *= value

  return totalScore

calculateCalories = (ingredients, amounts) ->
  totalCalories = 0
  for key, amount of amounts
    totalCalories += ingredients[key].calories * amount

  return totalCalories

findBestScore = (ingredients, totalAmounts = 100, targetCalories = null) ->
  ingredientsKeys = (key for key of ingredients)

  bestScore = 0
  bestCombo = null
  for c in combos(ingredientsKeys.length, totalAmounts)
    amounts = {}
    for ingredient, i in ingredientsKeys
      amounts[ingredient] = c[i]
    if targetCalories? and calculateCalories(ingredients, amounts) != targetCalories
      continue
    score = calculateScore(ingredients, amounts)
    if score > bestScore
      bestScore = score
      bestCombo = amounts

  return bestScore

combos = (length, totalAmount = 100) ->
  ret = []
  if length == 1
    return [[totalAmount]]
  else
    for amount in [0..totalAmount]
      focus = combos(length - 1, totalAmount - amount)
      for i in [0...focus.length]
        focus[i].unshift(amount)
        ret.push(focus[i])
    return ret

module.exports.calculateScore = calculateScore
module.exports.findBestScore = findBestScore
module.exports.combos = combos

main = () ->
  rl = require('readline').createInterface(
    input: require('fs').createReadStream('day15input.txt')
  )


  lineRE1 = /(\w+): ([-\w, ]*)/
  lineRE2 = /(\w+) ([-\d]+)/

  ingredients = {}

  rl.on 'line', (line) ->
    res1 = line.match(lineRE1)
    if res1
      ingredientName = res1[1]
      ingredients[ingredientName] = {}
      ingredientProperties = res1[2].split(',')
      for pLine in ingredientProperties
        res2 = pLine.match(lineRE2)
        if res2
          # console.log(res2)
          propertyName = res2[1]
          propertyValue = parseInt(res2[2])
          ingredients[ingredientName][propertyName] = propertyValue

  rl.on 'close', ->
    # console.log(permutations(['apple'], 100))
    # console.log(permutations(['apple', 'banana'], 10))
    # for c in combos(4, 100)


    # console.log(c.length)
    # console.log(ingredients)
    # findBestScore(ingredients)
    console.log(findBestScore(ingredients, 100))
    console.log(findBestScore(ingredients, 100, 500))


if require.main == module
  main()
