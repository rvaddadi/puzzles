var _ = require('underscore')._;

module.exports.calculate = calculate;

var monetaryUnits = [100, 50, 10, 5, 1, 0.50, 0.10, 0.05, 0.01];

function calculate(totalValue, paidValue) {
  var difference = paidValue - totalValue;
  var result     = 0;

  if (difference < 0) {
    throw {
      type: 'InvalidValue',
      message: 'The total value is more than the paid value'
    };
  }
  else if (difference > 0) {
    _(monetaryUnits).each(function(monetaryUnit) {
      var quotient;

      quotient = Math.floor(difference / monetaryUnit);

      result    += quotient;
      difference = Math.round((difference - quotient * monetaryUnit) * 100) / 100;

    });
  }

  return result;
};
