chai = require 'chai'
should = chai.should()
expect = chai.expect
day21 = require '../day21.coffee'

describe 'Day 21', ->
  player = {hp: 8, damage: 5, armor: 5}
  boss = {hp: 12, damage: 7, armor: 2}

  it 'should determine the outcome of a fight', ->
    expect(day21.simFight(player, boss)).to.deep.equal({player: 2, boss: 0})
