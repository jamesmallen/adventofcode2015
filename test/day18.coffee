chai = require 'chai'
should = chai.should()
expect = chai.expect
day18 = require '../day18.coffee'

describe 'Day 18', ->
  it 'should simulate steps of the animation', ->
    initialState = '''
                   .#.#.#
                   ...##.
                   #....#
                   ..#...
                   #.#..#
                   ####..
                   '''
    grid = new day18.LightGrid(initialState)

    iterations = [
      '''
      ..##..
      ..##.#
      ...##.
      ......
      #.....
      #.##..
      '''
      '''
      ..###.
      ......
      ..###.
      ......
      .#....
      .#....
      '''
      '''
      ...#..
      ......
      ...#..
      ..##..
      ......
      ......
      '''
      '''
      ......
      ......
      ..##..
      ..##..
      ......
      ......
      '''
    ]

    for iteration in iterations
      grid.tick()
      expect(grid.toString()).to.equal(iteration)

    expect(grid.lightsOn()).to.equal(4)
