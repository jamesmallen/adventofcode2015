chai = require 'chai'
should = chai.should()
expect = chai.expect
day13 = require '../day13.coffee'

describe 'Day 13', ->
  deltas = {
    'Alice': {
      'Bob': 54
      'Carol': -79
      'David': -2
    }
    'Bob': {
      'Alice': 83
      'Carol': -7
      'David': -63
    }
    'Carol': {
      'Alice': -62
      'Bob': 60
      'David': 55
    }
    'David': {
      'Alice': 46
      'Bob': -7
      'Carol': 41
    }
  }
  it 'should calculate the overall happiness delta for a given arrangement', ->
    expect(day13.calculateHappiness(deltas, ['David', 'Alice', 'Bob', 'Carol'])).to.equal(330)
  it 'should calculate the optimal happiness for all possible arrangements', ->
    console.log(day13.calculateOptimalArrangement(deltas))
    expect(day13.calculateHappiness(deltas, day13.calculateOptimalArrangement(deltas))).to.equal(330)
