var _ = require('underscore');

module.exports = GameOfLife;

function GameOfLife(grid) {

  grid.traverse = function(act) {
    var i;
    var j;

    for (i = 0; i < grid.length; i++) {
      for (j = 0; j < grid[i].length; j++) {
        act(i, j);
      }
    }
  };

  var neighbors = function(i, j) {
    var neighbors = [];

    if (i > 0) {
      if (j > 0) {
        neighbors.push(grid[i - 1][j - 1]);
      }
      neighbors.push(grid[i - 1][j]);
      if (j < grid[i - 1].length - 1) {
        neighbors.push(grid[i - 1][j + 1]);
      }
    }

    if (j > 0) {
      neighbors.push(grid[i][j - 1]);
    }
    if (j < grid[i].length - 1) {
      neighbors.push(grid[i][j + 1]);
    }

    if (i < grid.length - 1) {
      if (j > 0) {
        neighbors.push(grid[i + 1][j - 1]);
      }
      neighbors.push(grid[i + 1][j]);
      if (j < grid[i + 1].length - 1) {
        neighbors.push(grid[i + 1][j + 1]);
      }
    }

    return neighbors;
  };

  this.nextGeneration = function() {
    var newGrid = [];

    _(grid).each(function() { newGrid.push([]); });

    grid.traverse(function(i, j) {
      var liveNeighbors = _(neighbors(i, j))
        .filter(function(cell){ return cell == 1; })
        .length;

      if (liveNeighbors < 2) {
        newGrid[i][j] = 0;
      }
      else if (liveNeighbors == 2) {
        newGrid[i][j] = grid[i][j];
      }
      else if (liveNeighbors == 3) {
        newGrid[i][j] = 1;
      }
      else if (liveNeighbors > 3) {
        newGrid[i][j] = 0;
      }
    });

    grid = newGrid;

    return this;
  };

  this.getGrid = function() { return grid; };
};
