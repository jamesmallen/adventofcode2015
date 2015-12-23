chai = require 'chai'
should = chai.should()
expect = chai.expect
day14 = require '../day14.coffee'

describe 'Day 14', ->
  reindeer = [
    [14, 10, 127]
    [16, 11, 162]
  ]
  tests = [
    [1, [14, 16]]
    [10, [140, 160]]
    [11, [140, 176]]
    [12, [140, 176]]
    [1000, [1120, 1056]]
  ]
  it 'should calculate the distance a reindeer has gone after a specified number of ticks', ->
    for t in tests
      actualDeer = []
      for r in reindeer
        actualDeer.push(new day14.Reindeer(r...))
      for _ in [0...t[0]]
        for r in actualDeer
          r.tick()
      for i in [0...t[1].length]
        expect(actualDeer[i].distance).to.equal(t[1][i])
