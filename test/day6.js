var assert = require('assert'),
    expect = require('chai').expect,
    day6 = require('../day6.js'),
    emptyGrid = day6.emptyGrid;

describe('day6 part a', function() {
});
describe('helper functions', function() {
  it('should turn lights on', function() {
    var grid = emptyGrid(3, 3);
    expect(grid).to.deep.equal([[0, 0, 0],
                                [0, 0, 0],
                                [0, 0, 0]]);

    grid = emptyGrid(3, 3);
    day6.turnOn(grid, 0, 0, 0, 0);
    expect(grid).to.deep.equal([[1, 0, 0],
                                [0, 0, 0],
                                [0, 0, 0]]);

    grid = emptyGrid(3, 3);
    day6.turnOn(grid, 2, 2, 2, 2);
    expect(grid).to.deep.equal([[0, 0, 0],
                                [0, 0, 0],
                                [0, 0, 1]]);

    grid = emptyGrid(3, 3);
    day6.turnOn(grid, 0, 0, 2, 2);
    expect(grid).to.deep.equal([[1, 1, 1],
                                [1, 1, 1],
                                [1, 1, 1]]);

  });
  it('should turn lights off', function() {
    var grid = emptyGrid(3, 3, 1);
    expect(grid).to.deep.equal([[1, 1, 1],
                                [1, 1, 1],
                                [1, 1, 1]]);

    grid = emptyGrid(3, 3, 1);
    day6.turnOff(grid, 0, 0, 0, 0);
    expect(grid).to.deep.equal([[0, 1, 1],
                                [1, 1, 1],
                                [1, 1, 1]]);

    grid = emptyGrid(3, 3, 1);
    day6.turnOff(grid, 2, 2, 2, 2);
    expect(grid).to.deep.equal([[1, 1, 1],
                                [1, 1, 1],
                                [1, 1, 0]]);

    grid = emptyGrid(3, 3, 1);
    day6.turnOff(grid, 0, 0, 2, 2);
    expect(grid).to.deep.equal([[0, 0, 0],
                                [0, 0, 0],
                                [0, 0, 0]]);

  });
  it('should toggle lights', function() {
    var grid = [[0, 1, 0],
                [1, 0, 1],
                [0, 0, 1]];
    day6.toggle(grid, 0, 0, 2, 2);
    expect(grid).to.deep.equal([[1, 0, 1],
                                [0, 1, 0],
                                [1, 1, 0]]);

  });
});
