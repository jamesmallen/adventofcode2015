chai = require 'chai'
should = chai.should()
expect = chai.expect
day11 = require '../day11.coffee'

describe 'Day 11', ->
  it 'should convert passwords to numbers', ->
    expect(day11.passwordToNumber('aab')).to.be.greaterThan(day11.passwordToNumber('aaa'))
    expect(day11.passwordToNumber('aai')).to.be.greaterThan(day11.passwordToNumber('aah'))
    expect(day11.passwordToNumber('aaiaa')).to.be.greaterThan(day11.passwordToNumber('aahaa'))
  it 'should find straight sequences of characters', ->
    validPasswords = [
      'hijklmmn',
      'abcaaaaa'
    ]
    invalidPasswords = [
      'abbceffg',
    ]
    for p in validPasswords
      expect(day11.hasStraight(p)).to.be.ok
    for p in invalidPasswords
      expect(day11.hasStraight(p)).to.not.be.ok
  it 'should count pairs of characters', ->
    tests = [
      ['abbceffg', 2]
      ['abbcegjk', 1]
      ['ghjaabcc', 2]
      ['abcdffaa', 2]
      ['abbbabcd', 1]
    ]
    for t in tests
      expect(day11.countPairs(t[0])).to.equal(t[1])
  it 'should identify valid and invalid passwords', ->
    validPasswords = [
      'abcdffaa',
      'ghjaabcc'
    ]
    invalidPasswords = [
      'hijklmmn',
      'abbceffg',
      'abbcegjk',
      'ghijklmn',
      'abcdefgh'
    ]
    for p in validPasswords
      expect(day11.isValidPassword(p)).to.be.ok
    for p in invalidPasswords
      expect(day11.isValidPassword(p)).to.not.be.ok
  it 'should calculate the next valid password', ->
    tests = [
      ['abcdefgh', 'abcdffaa']
      ['ghijklmn', 'ghjaabcc']
    ]
    for t in tests
      expect(day11.nextValidpassword(t[0])).to.equal(t[1])
