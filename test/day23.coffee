chai = require 'chai'
should = chai.should()
expect = chai.expect
day23 = require '../day23.coffee'

describe 'Day 23', ->
  it 'should run a program', ->
    prog = '''
    inc a
    jio a, +2
    tpl a
    inc a
    '''

    expect(day23.runProg(prog).a).to.equal(2)
