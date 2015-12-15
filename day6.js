;(function() {

  exports.main = main;

  exports.turnOn = turnOn;
  exports.turnOff = turnOff;
  exports.toggle = toggle;
  exports.emptyGrid = emptyGrid;


  function emptyGrid(rows, cols, defaultValue) {
    if (defaultValue === undefined) {
      defaultValue = 0;
    }
    var ret = [],
        row = [],
        i;
    for (i = 0; i < cols; i++) {
      row.push(defaultValue);
    }
    for (i = 0; i < rows; i++) {
      ret.push(row.slice());
    }
    return ret;
  }


  function turnOn(grid, row1, col1, row2, col2) {
    for (var i = row1; i <= row2; i++) {
      for (var j = col1; j <= col2; j++) {
        grid[i][j] = 1;
      }
    }
  }

  function turnOff(grid, row1, col1, row2, col2) {
    for (var i = row1; i <= row2; i++) {
      for (var j = col1; j <= col2; j++) {
        grid[i][j] = 0;
      }
    }
  }

  function toggle(grid, row1, col1, row2, col2) {
    for (var i = row1; i <= row2; i++) {
      for (var j = col1; j <= col2; j++) {
        if (grid[i][j] === 0) {
          grid[i][j] = 1;
        } else {
          grid[i][j] = 0;
        }
      }
    }
  }

  function turnOn2(grid, row1, col1, row2, col2) {
    for (var i = row1; i <= row2; i++) {
      for (var j = col1; j <= col2; j++) {
        grid[i][j] += 1;
      }
    }
  }

  function turnOff2(grid, row1, col1, row2, col2) {
    for (var i = row1; i <= row2; i++) {
      for (var j = col1; j <= col2; j++) {
        grid[i][j] = Math.max(grid[i][j] - 1, 0);
      }
    }
  }

  function toggle2(grid, row1, col1, row2, col2) {
    for (var i = row1; i <= row2; i++) {
      for (var j = col1; j <= col2; j++) {
          grid[i][j] += 2;
      }
    }
  }

  function countOnLights(grid) {
    var counter = 0;
    for (var i = 0; i < grid.length; i++) {
      for (var j = 0; j < grid[i].length; j++) {
        if (grid[i][j] !== 0) {
          counter++;
        }
      }
    }
    return counter;
  }

  function totalBrightness(grid) {
    var counter = 0;
    for (var i = 0; i < grid.length; i++) {
      for (var j = 0; j < grid[i].length; j++) {
        counter += grid[i][j];
      }
    }
    return counter;
  }

  function main() {
    // main code
    var rl = require('readline').createInterface({
      input: require('fs').createReadStream('day6input.txt')
    });
    var grid = emptyGrid(1000, 1000, 0),
        grid2 = emptyGrid(1000, 1000, 0);

    rl.on('line', function(line) {
      var res = line.match(/turn on (\d+),(\d+) through (\d+),(\d+)/);
      if (res) {
        turnOn(grid, parseInt(res[1]), parseInt(res[2]), parseInt(res[3]), parseInt(res[4]));
        turnOn2(grid2, parseInt(res[1]), parseInt(res[2]), parseInt(res[3]), parseInt(res[4]));
      }
      res = line.match(/turn off (\d+),(\d+) through (\d+),(\d+)/);
      if (res) {
        turnOff(grid, parseInt(res[1]), parseInt(res[2]), parseInt(res[3]), parseInt(res[4]));
        turnOff2(grid2, parseInt(res[1]), parseInt(res[2]), parseInt(res[3]), parseInt(res[4]));
      }
      res = line.match(/toggle (\d+),(\d+) through (\d+),(\d+)/);
      if (res) {
        toggle(grid, parseInt(res[1]), parseInt(res[2]), parseInt(res[3]), parseInt(res[4]));
        toggle2(grid2, parseInt(res[1]), parseInt(res[2]), parseInt(res[3]), parseInt(res[4]));
      }
    });
    rl.on('close', function() {
      console.log(countOnLights(grid));
      console.log(totalBrightness(grid2));
    });

  }

  if (require.main === module) {
    main();
  }

})();
