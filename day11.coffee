digitMap = {
  'a': '0'
  'b': '1'
  'c': '2'
  'd': '3'
  'e': '4'
  'f': '5'
  'g': '6'
  'h': '7'
  'i': '8'
  'j': '9'
  'k': 'a'
  'l': 'b'
  'm': 'c'
  'n': 'd'
  'o': 'e'
  'p': 'f'
  'q': 'g'
  'r': 'h'
  's': 'i'
  't': 'j'
  'u': 'k'
  'v': 'l'
  'w': 'm'
  'x': 'n'
  'y': 'o'
  'z': 'p'
}

# looseDigitMap = {
#   'i': '8'
#   'l': 'a'
#   'o': 'c'
# }

reverseDigitMap = {}
for key, value of digitMap
  reverseDigitMap[value] = key

pad = (s, size, c='0') ->
  c = c.toString()
  s = s.toString()
  while (s.length < size)
    s = c + s
  return s

numberToPassword = (n) ->
  s = pad(n.toString(26), 8, '0')
  s = (reverseDigitMap[c] for c in s).join('')
  return s

passwordToNumber = (s) ->
  n = (digitMap[c] || looseDigitMap[c] for c in s).join('')
  n = parseInt(n, 26)
  return n

hasStraight = (s, runLength = 3) ->
  # s = (digitMap[c] for c in s).join('')

  for i in [0..s.length - runLength]
    startValue = parseInt(s[i], 36)
    broken = false
    for j in [1...runLength]
      if parseInt(s[i+j], 36) != startValue + j
        broken = true
        break
    if not broken
      return true

  return false


countPairs = (s) ->
  result = s.match(/(\w)\1/g)
  if result?
    return result.length
  else
    return 0


hasValidChars = (s) ->
  return false for c in s when c == 'i' or c == 'l' or c == 'o'
  return true


isValidPassword = (s) ->
  if hasValidChars(s) and hasStraight(s, 3) and countPairs(s) >= 2
    return true
  else
    return false

nextValidpassword = (s) ->
  n = passwordToNumber(s)
  n += 1
  loop
    s = numberToPassword(n)
    if isValidPassword(s)
      return s
    if n % 1000 == 0
      console.log(n, s)
    n++

module.exports.isValidPassword = isValidPassword
module.exports.nextValidpassword = nextValidpassword
module.exports.hasStraight = hasStraight
module.exports.hasValidChars = hasValidChars
module.exports.countPairs = countPairs
module.exports.digitMap = digitMap
module.exports.reverseDigitMap = reverseDigitMap
module.exports.pad = pad
module.exports.numberToPassword = numberToPassword
module.exports.passwordToNumber = passwordToNumber

main = () ->
  rl = require('readline').createInterface(
    input: require('fs').createReadStream('day11input.txt')
  )
  res = ''

  rl.on 'line', (line) ->
    # TODO

  rl.on 'close', ->
    # TODO

if require.main == module
  main()
