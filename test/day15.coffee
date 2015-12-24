chai = require 'chai'
should = chai.should()
expect = chai.expect
day15 = require '../day15.coffee'

describe 'Day 15', ->
  ingredients = {
    Butterscotch: {
      capacity: -1, durability: -2, flavor: 6, texture: 3, calories: 8
    }
    Cinnamon: {
      capacity: 2, durability: 3, flavor: -2, texture: -1, calories: 3
    }
  }

  tests = [
    {
      ingredients: {Butterscotch: 44, Cinnamon: 56},
      properties: {capacity: 68, durability: 80, flavor: 152, texture: 76},
      score: 62842880
    }
  ]
  it 'should calculate the score of a recipe', ->
    for t in tests
      console.log(t)
      expect(day15.calculateScore(ingredients, t.ingredients)).to.equal(t.score)
  it 'should find the best score for a set of ingredients', ->
    expect(day15.findBestScore(ingredients)).to.equal(tests[0].score)
