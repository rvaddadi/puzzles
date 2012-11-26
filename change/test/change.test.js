var should = require('should');
var change = require('../lib/change.js');

describe('change', function() {

  describe('calculate', function() {

    it('should throw if less than the total value is paid', function() {
      (function(){
        change.calculate(2, 1);
      }).should.throw();
    });

    it('should give no change when paid is equal to total value', function(){
      change.calculate(2, 2).should.equal(0);
    });

    it('should one dollar as change', function(){
      change.calculate(1, 2).should.equal(1);
    });

    it('should five dollars as change', function(){
      change.calculate(70, 75).should.equal(1);
    });

    it('should two different values as change', function(){
      change.calculate(69.90, 75).should.equal(2);
    });
  });
});
