
class Reindeer
  constructor: (@speed, @flyDuration, @restDuration) ->
    @init()

  init: ->
    @state = 'flying'
    @timeLeft = @flyDuration
    @distance = 0
    @points = 0

  tick: ->
    if @timeLeft <= 0
      if @state == 'flying'
        @state = 'resting'
        @timeLeft = @restDuration
      else
        @state = 'flying'
        @timeLeft = @flyDuration

    if @state == 'flying'
      @distance += @speed

    @timeLeft -= 1



module.exports.Reindeer = Reindeer


main = () ->
  rl = require('readline').createInterface(
    input: require('fs').createReadStream('day14input.txt')
  )

  reindeer = {}
  inputRE = /(\w+) can fly (\d+) km\/s for (\d+) seconds, but then must rest for (\d+) seconds\./
  numTicks = 2503

  rl.on 'line', (line) ->
    res = line.match(inputRE)
    reindeer[res[1]] = new Reindeer(parseInt(res[2]), parseInt(res[3]), parseInt(res[4]))

  rl.on 'close', ->
    for _ in [0...numTicks]
      leadDistance = 0
      leader = null
      for name, r of reindeer
        r.tick()
        if r.distance > leadDistance
          leadDistance = r.distance
          leader = name
      reindeer[leader].points += 1

    for name, r of reindeer
      console.log(name + ': ' + r.distance + " km, (" + r.points + " points)")


if require.main == module
  main()
