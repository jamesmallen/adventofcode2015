chai = require 'chai'
should = chai.should()
expect = chai.expect
day12 = require '../day12.coffee'

describe 'Day 12', ->
  it 'should find objects that are red', ->
    expect(day12.hasRed({"c":"red","b":2})).to.be.true
    expect(day12.hasRed([1,2,3])).to.not.be.true
    expect(day12.hasRed([1,"red",5])).to.not.be.true
    expect(day12.hasRed({"a":[120,169,"green","red","orange"],"b":"red"})).to.be.true
  it 'should sum JSON trees', ->
    tests = [
      [[1,2,3], 6]
      [{"a":2,"b":4}, 6]
      [[[[3]]], 3]
      [{"a":{"b":4},"c":-1}, 3]
      [{"a":[-1,1]}, 0]
      [[-1,{"a":1}], 0]
      [[], 0]
      [{}, 0]
    ]
    for t in tests
      expect(day12.sumNodes(t[0])).to.equal(t[1])
