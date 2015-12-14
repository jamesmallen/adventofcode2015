;(function() {
  // exports.hello = hello;

  // exports.hello();

  // function hello(){
  //   console.log('Hello from main.js!');
  // }

  exports.isNice = isNice;
  exports.countSubstring = countSubstring;

  function countSubstring(haystack, needle) {
    re = new RegExp(needle, "g");
    return (haystack.match(re) || []).length;
  }

  function isNice(s) {
    if (countSubstring(s, '[aeiou]') >= 3 &&
        countSubstring(s, '([a-zA-Z])\\1') >= 1 &&
        countSubstring(s, 'ab') === 0 &&
        countSubstring(s, 'cd') === 0 &&
        countSubstring(s, 'pq') === 0 &&
        countSubstring(s, 'xy') === 0) {
      return true;
    } else {
      return false;
    }
  }

  var main = function() {
    // main code
    var rl = require('readline').createInterface({
      input: require('fs').createReadStream('day5input.txt')
    });

    var niceCount = 0;
    rl.on('line', function(line) {
      if (isNice(line)) {
        niceCount++;
      }
    });
    rl.on('close', function() {
      console.log(niceCount);
    });

  }

  if (require.main === module) {
    main();
  }

})();
