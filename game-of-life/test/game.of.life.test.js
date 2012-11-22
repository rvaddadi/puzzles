var assert     = require('assert');

var GameOfLife = require('../lib/game.of.life.js');

describe('GameOfLife', function(){

  var assertNextGenerationGrid = function(grid, nextGenerationGrid) {
    assert.deepEqual(nextGenerationGrid,
      new GameOfLife(grid).nextGeneration().getGrid());
  };

  it('should have a grid', function(){
    var grid = [
      [0, 0, 0],
      [0, 0, 0],
      [0, 0, 0]
    ];

    assert.deepEqual(grid, new GameOfLife(grid).getGrid());
  });

  it('should kill cells with less then 2 neighbors', function() {
    assertNextGenerationGrid([
      [0, 0, 0],
      [0, 1, 0],
      [0, 0, 0]
    ], [
      [0, 0, 0],
      [0, 0, 0],
      [0, 0, 0]
    ]);
    assertNextGenerationGrid([
      [0, 1, 0],
      [0, 1, 0],
      [0, 0, 0]
    ], [
      [0, 0, 0],
      [0, 0, 0],
      [0, 0, 0]
    ]);
  });

  it('should kill cells with more then 3 neighbors', function() {
    assertNextGenerationGrid([
      [0, 1, 0],
      [1, 1, 1],
      [0, 1, 0]
    ], [
      [1, 1, 1],
      [1, 0, 1],
      [1, 1, 1]
    ]);
    assertNextGenerationGrid([
      [1, 0, 1],
      [0, 1, 0],
      [1, 0, 1]
    ], [
      [0, 1, 0],
      [1, 0, 1],
      [0, 1, 0]
    ]);
  });

  it('should keep cells with 2 or 3 neighbors', function() {
    assertNextGenerationGrid([
      [0, 1, 0],
      [0, 1, 1],
      [0, 0, 0]
    ], [
      [0, 1, 1],
      [0, 1, 1],
      [0, 0, 0]
    ]);
  });

  it('should give life to cells with 3 neighbors', function() {
    assertNextGenerationGrid([
      [0, 1, 0],
      [0, 1, 1],
      [0, 0, 0]
    ], [
      [0, 1, 1],
      [0, 1, 1],
      [0, 0, 0]
    ]);
  });
});
