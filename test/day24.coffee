chai = require 'chai'
should = chai.should()
expect = chai.expect
day24 = require '../day24.coffee'

describe 'Day 24', ->
  packages = [1..5].concat([7..11])
  # it 'should find the ways of arranging the packages with equal weights', ->
  #   arrangements = day24.arrangements(packages)
  #   expect(arrangements.length).to.equal(13)
  it 'should find unique combinations of arrays', ->
    tests = [
      [[[1], [2], [3]], 2, true]
      [[[1], [2], [3]], 3, true]
      [[[1], [2], [3], [3]], 4, false]
      [[[1, 2], [3, 4], [5, 6]], 2, true]
      [[[1, 2], [3, 4], [5, 6]], 3, true]
      [[[1, 2], [1, 3], [1, 4]], 2, false]
      [[[1, 2], [1, 3], [1, 4]], 3, false]
      [[[1, 2], [3, 4], [5, 2]], 3, false]
      [[[1, 2], [3, 4], [5, 6], [7, 8]], 2, true]
    ]
    for t in tests
      expect(day24.hasUniqueCombinations(t[0], t[1])).to.equal(t[2])
  it 'should find the arrangement(s) with the least number of packages in the passenger compartment', ->
    fewest = day24.fewestPackages(packages)
    expect(fewest).to.deep.equal([[9, 11]])
  # it 'should return the lowest quantum entanglement of possible arrangements', ->
  #   arrangements = day24.arrangements(packages)
  #   fewest = day24.fewestPackages(arrangements)
  #   qe = day24.lowestQuantumEntanglement(fewest)
  #   expect(qe).to.equal(99)
