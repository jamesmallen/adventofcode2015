lengthOfFirstSequence = (s) ->
  found = s.match(/(\d)\1*/)
  return found[0].length


lookAndSay = (s) ->
  ret = ''
  while s.length > 0
    seqLength = lengthOfFirstSequence(s)
    ret += seqLength.toString() + s[0]
    s = s[seqLength...]

  return ret

module.exports.lookAndSay = lookAndSay

main = () ->
  rl = require('readline').createInterface(
    input: require('fs').createReadStream('day10input.txt')
  )
  res = ''

  rl.on 'line', (line) ->
    puzzleInput = line
    repetitions = 50
    res = puzzleInput.toString()
    res = lookAndSay(res) for [0...repetitions]

  rl.on 'close', ->
    console.log(res.length)

if require.main == module
  main()
