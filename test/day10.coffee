chai = require 'chai'
should = chai.should()
expect = chai.expect
day10 = require '../day10.coffee'

describe 'Look and Say', ->
  it 'should generate sequences correctly', ->
    tests = [
      ['1', '11'],
      ['11', '21'],
      ['21', '1211'],
      ['1211', '111221'],
      ['111221', '312211'],
    ]
    for t in tests
      expect(day10.lookAndSay(t[0])).to.equal(t[1])
