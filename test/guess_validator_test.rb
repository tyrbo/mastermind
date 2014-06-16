require './test/test_helper'
require './lib/guess_validator'

class GuessValidatorTest < MiniTest::Test
  def test_it_returns_true_for_a_valid_guess
    assert GuessValidator.valid?('RGBY')
    assert GuessValidator.valid?('YYYY')
    assert GuessValidator.valid?('GBGR')
    assert GuessValidator.valid?('BBRR')
  end

  def test_it_returns_false_for_an_invalid_guess
    refute GuessValidator.valid?('OOOO')
    refute GuessValidator.valid?('0000')
    refute GuessValidator.valid?(false)
    refute GuessValidator.valid?(nil)
    refute GuessValidator.valid?(0.1)
  end
end
