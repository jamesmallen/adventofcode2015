chai = require 'chai'
should = chai.should()
expect = chai.expect
day17 = require '../day17.coffee'

describe 'Day 17', ->
  containers = [
    20, 15, 10, 5, 5
  ]
  combinations = [
    [15, 10],
    [20, 5],
    [20, 5],
    [15, 5, 5]
  ]
  it 'should count the number of ways to store 25 liters', ->
    expect(day17.countCombinations([5], 5)).to.equal(1)
    expect(day17.countCombinations([5, 5], 5)).to.equal(2)
    expect(day17.countCombinations([5, 1, 5], 5)).to.equal(2)
    expect(day17.countCombinations([2, 3, 5], 5)).to.equal(2)
    expect(day17.countCombinations(containers, 25)).to.equal(4)
