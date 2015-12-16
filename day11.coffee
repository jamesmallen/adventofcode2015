digitMap = {
  'a': '0'
  'b': '1'
  'c': '2'
  'd': '3'
  'e': '4'
  'f': '5'
  'g': '6'
  'h': '7'
  'j': '8'
  'k': '9'
  'm': 'a'
  'n': 'b'
  'p': 'c'
  'q': 'd'
  'r': 'e'
  's': 'f'
  't': 'g'
  'u': 'h'
  'v': 'i'
  'w': 'j'
  'x': 'k'
  'y': 'l'
  'z': 'm'
}

looseDigitMap = {
  'i': '8'
  'l': 'a'
  'o': 'c'
}

reverseDigitMap = {}
for key, value of digitMap
  reverseDigitMap[value] = key

pad = (s, size, c='0') ->
  c = c.toString()
  s = s.toString()
  while (s.length < size)
    s = c + s
  return s

rpad = (s, size, c='0') ->
  c = c.toString()
  s = s.toString()
  while (s.length < size)
    s = s + c
  return s


numberToPassword = (n) ->
  s = pad(n.toString(23), 8, '0')
  s = (reverseDigitMap[c] for c in s).join('')
  return s

passwordToNumber = (s) ->
  t = ''
  for c in s
    if digitMap[c]?
      t += digitMap[c]
    else
      t += looseDigitMap[c]
      t = rpad(t, s.length, '0')
      break

  # n = (digitMap[c] || looseDigitMap[c] for c in t).join('')
  n = parseInt(t, 23)
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
  return false for c in s when not digitMap[c]?
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
    n++

module.exports.isValidPassword = isValidPassword
module.exports.nextValidpassword = nextValidpassword
module.exports.hasStraight = hasStraight
module.exports.hasValidChars = hasValidChars
module.exports.countPairs = countPairs
module.exports.digitMap = digitMap
module.exports.reverseDigitMap = reverseDigitMap
module.exports.pad = pad
module.exports.rpad = rpad
module.exports.numberToPassword = numberToPassword
module.exports.passwordToNumber = passwordToNumber

main = () ->
  rl = require('readline').createInterface(
    input: require('fs').createReadStream('day11input.txt')
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
