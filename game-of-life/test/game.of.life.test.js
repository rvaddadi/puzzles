var assert     = require('assert');

var GameOfLife = require('../lib/game.of.life.js');

describe('GameOfLife', function(){

  it('should have a grid', function(){
    var grid = [
      [0, 0, 0],
      [0, 0, 0],
      [0, 0, 0]
    ];

    assert.deepEqual(new GameOfLife(grid).getGrid(), grid);
  });

  it('should kill cells with less then 2 neighbors', function() {
    assert.deepEqual(new GameOfLife([
        [0, 0, 0],
        [0, 1, 0],
        [0, 0, 0]
      ]).nextGeneration().getGrid(), [
        [0, 0, 0],
        [0, 0, 0],
        [0, 0, 0]
      ]);
    assert.deepEqual(new GameOfLife([
        [0, 1, 0],
        [0, 1, 0],
        [0, 0, 0]
      ]).nextGeneration().getGrid(), [
        [0, 0, 0],
        [0, 0, 0],
        [0, 0, 0]
      ]);
  });

  it('should kill cells with more then 3 neighbors', function() {
    assert.deepEqual(new GameOfLife([
        [0, 1, 0],
        [1, 1, 1],
        [0, 1, 0]
      ]).nextGeneration().getGrid(), [
        [1, 1, 1],
        [1, 0, 1],
        [1, 1, 1]
      ]);
    assert.deepEqual(new GameOfLife([
        [1, 0, 1],
        [0, 1, 0],
        [1, 0, 1]
      ]).nextGeneration().getGrid(), [
        [0, 1, 0],
        [1, 0, 1],
        [0, 1, 0]
      ]);
  });

  it('should keep cells with 2 or 3 neighbors', function() {
    assert.deepEqual(new GameOfLife([
        [0, 1, 0],
        [0, 1, 1],
        [0, 0, 0]
      ]).nextGeneration().getGrid(), [
        [0, 1, 1],
        [0, 1, 1],
        [0, 0, 0]
      ]);
  });

  it('should give life to cells with 3 neighbors', function() {
    assert.deepEqual(new GameOfLife([
        [0, 1, 0],
        [0, 1, 1],
        [0, 0, 0]
      ]).nextGeneration().getGrid(), [
        [0, 1, 1],
        [0, 1, 1],
        [0, 0, 0]
      ]);
  });
});
