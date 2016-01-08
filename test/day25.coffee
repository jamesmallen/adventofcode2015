chai = require 'chai'
should = chai.should()
expect = chai.expect
day25 = require '../day25.coffee'

describe 'Day 25', ->
  packages = [1..5].concat([7..11])
  # it 'should find the ways of arranging the packages with equal weights', ->
  #   arrangements = day25.arrangements(packages)
  #   expect(arrangements.length).to.equal(13)
  codes = [
    [20151125,  18749137,  17289845,  30943339,  10071777,  33511524]
    [31916031,  21629792,  16929656,   7726640,  15514188,   4041754]
    [16080970,   8057251,   1601130,   7981243,  11661866,  16474243]
    [24592653,  32451966,  21345942,   9380097,  10600672,  31527494]
    [   77061,  17552253,  28094349,   6899651,   9250759,  31663883]
    [33071741,   6796745,  25397450,  24659492,   1534922,  27995004]
  ]

  it 'should find the next code', ->
    expect(day25.findNextCode(codes[0][0])).to.equal(codes[1][0])
    expect(day25.findNextCode(codes[1][0])).to.equal(codes[0][1])
    expect(day25.findNextCode(codes[0][1])).to.equal(codes[2][0])
    expect(day25.findNextCode(codes[2][0])).to.equal(codes[1][1])
    expect(day25.findNextCode(codes[1][1])).to.equal(codes[0][2])

  it 'should look up codes', ->
    expect(day25.lookupCode(1, 1)).to.equal(codes[0][0])
    expect(day25.lookupCode(2, 1)).to.equal(codes[1][0])
    expect(day25.lookupCode(2, 1)).to.equal(codes[1][0])
    expect(day25.lookupCode(6, 6)).to.equal(codes[5][5])
    # console.log(day25.codes)
