// var test = require('mocha').it,
//     expect = require('chai').expect,
//     main = require('./main.js');
//
// main.hello(); // Just a sanity check...





var assert = require('assert'),
    expect = require('chai').expect,
    main = require('../day5.js');
describe('day5 part a', function() {
  it('should find nice strings', function() {
    expect(main.isNice('ugknbfddgicrmopn')).to.be.ok;
    expect(main.isNice('aaa')).to.be.ok;
  });
  it('should find naughty strings', function() {
    expect(main.isNice('jchzalrnumimnmhp')).to.not.be.ok;
    expect(main.isNice('haegwjzuvuyypxyu')).to.not.be.ok;
    expect(main.isNice('dvszwmarrgswjxmb')).to.not.be.ok;
  });
});
describe('helper functions', function() {
  it('should count occurrences of characters in a substring', function() {
    expect(main.countSubstring('hohoho', 'ho')).to.equal(3);
    expect(main.countSubstring('aeiou', 'x')).to.equal(0);
    expect(main.countSubstring('str1,str2,str3,str4', ',')).to.equal(3);
    expect(main.countSubstring('str1,str2,str3,str4', 'str')).to.equal(4);
  });
  it('should count occurrences of regexs in a substring', function() {
    expect(main.countSubstring('the quick brown fox', '[aeiou]')).to.equal(5);
    expect(main.countSubstring('zyzzygy', '[aeiou]')).to.equal(0);
  });
});
describe('day5 part b', function() {
  it('should find nice strings', function() {
    [
      'qjhvhtzxzqqjkmpb',
      'xxyxx'
    ].forEach(function(item) {
      expect(main.isNice2(item)).to.be.ok;
    });
  });
  it('should find naughty strings', function() {
    [
      'uurcxstgmygtbstg',
      'ieodomkazucvgmuy'
    ].forEach(function(item) {
      expect(main.isNice2(item)).to.not.be.ok;
    });
  });
})
