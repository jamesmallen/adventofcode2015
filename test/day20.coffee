chai = require 'chai'
should = chai.should()
expect = chai.expect
day20 = require '../day20.coffee'

describe 'Day 20', ->
  tests = [
    [1, 10]
    [2, 30]
    [3, 40]
    [4, 70]
    [5, 60]
    [6, 120]
    [7, 80]
    [8, 150]
    [9, 130]
  ]
  it 'should determine the number of presents delivered to a house', ->
    for t in tests
      expect(day20.presentsForHouse(t[0])).to.equal(t[1])
