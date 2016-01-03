chai = require 'chai'
should = chai.should()
expect = chai.expect
day19 = require '../day19.coffee'

describe 'Day 19', ->
  replacements = [
    ['H', 'HO']
    ['H', 'OH']
    ['O', 'HH']
  ]
  it 'should determine the distinct molecules generated', ->
    possibilities = day19.getPossibilities('HOH', replacements)
    expect(possibilities.length).to.equal(4)
    console.log(possibilities)
    possibilities = day19.getPossibilities('HOHOHO', replacements)
    expect(possibilities.length).to.equal(7)
    console.log(possibilities)
