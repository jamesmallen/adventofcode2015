;(function() {
  // exports.hello = hello;

  // exports.hello();

  // function hello(){
  //   console.log('Hello from main.js!');
  // }

  exports.isNice = isNice;
  exports.isNice2 = isNice2;
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

  function isNice2(s) {
    // It contains a pair of any two letters that appears at least twice in the string without overlapping, like xyxy (xy) or aabcdefgaa (aa), but not like aaa (aa, but it overlaps).
    // It contains at least one letter which repeats with exactly one letter between them, like xyx, abcdefeghi (efe), or even aaa.

    if (s.match(/([a-zA-Z]{2}).*\1/) &&
        s.match(/([a-zA-Z]).\1/)) {
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
    var nice2Count = 0;
    rl.on('line', function(line) {
      if (isNice(line)) {
        niceCount++;
      }
      if (isNice2(line)) {
        nice2Count++;
      }
    });
    rl.on('close', function() {
      console.log(niceCount);
      console.log(nice2Count);
    });

  }

  if (require.main === module) {
    main();
  }

})();
